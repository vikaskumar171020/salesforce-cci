#!/bin/bash
# ==============================================================================
# Local GitHub Workflow Simulator & Credentials Exporter Validator
#
# Purpose: Tests the markdown credentials generation logic from
#          .github/workflows/create-scratch-org.yml locally without hitting
#          Salesforce Scratch Org creation limits or requiring DevHub auth.
# ==============================================================================

set -e

# Color definitions
GREEN='\033[0;32m'
RED='\033[0;31m'
BLUE='\033[0;34m'
YELLOW='\033[0;33m'
NC='\033[0m' # No Color

echo -e "${BLUE}====================================================${NC}"
echo -e "${BLUE}🚀 Testing GitHub Actions Workflow Pipeline Locally ${NC}"
echo -e "${BLUE}====================================================${NC}\n"

# 1. Create a temporary directory for mock executables & test outputs
TMP_DIR=$(mktemp -d /tmp/workflow-test.XXXXXX)
MOCK_BIN="$TMP_DIR/bin"
mkdir -p "$MOCK_BIN"
export PATH="$MOCK_BIN:$PATH"

# 2. Mock 'cci' command (bypasses scratch org creation limit)
cat <<'EOF' > "$MOCK_BIN/cci"
#!/bin/bash
if [ "$1" = "flow" ] && [ "$2" = "run" ]; then
    echo "[MOCK CCI] Simulating CumulusCI flow run '$3' for org '$5'..."
    echo "[MOCK CCI] Scratch org created successfully (simulated)."
    exit 0
fi
echo "[MOCK CCI] Executing cci $@"
exit 0
EOF
chmod +x "$MOCK_BIN/cci"

# 3. Mock 'sf' CLI command for simulated org data
cat <<'EOF' > "$MOCK_BIN/sf"
#!/bin/bash
# Mock response for sf org display
if [[ "$*" == *"org display"* ]]; then
  cat <<'JSON'
{
  "status": 0,
  "result": {
    "id": "00D000000000001AAA",
    "apiVersion": "63.0",
    "accessToken": "00D000000000001!MOCK_ACCESS_TOKEN",
    "instanceUrl": "https://simulated-scratch-domain-dev-ed.scratch.my.salesforce.com",
    "username": "test-simulated-user@example.com",
    "clientId": "PlatformCLI",
    "connectedStatus": "Active",
    "alias": "dev",
    "orgName": "Simulated Scratch Org",
    "status": "Active",
    "createdDate": "2026-07-23T23:55:00.000+0000",
    "expirationDate": "2026-08-22"
  }
}
JSON
  exit 0
fi

# Mock response for sf org generate password
if [[ "$*" == *"org generate password"* ]]; then
  echo '{"status": 0, "result": {"password": "SimulatedSecretPassword123!"}}'
  exit 0
fi

# Mock response for sf org auth show-user-password
if [[ "$*" == *"org auth show-user-password"* ]]; then
  cat <<'JSON'
{
  "status": 0,
  "result": {
    "password": "SimulatedSecretPassword123!"
  }
}
JSON
  exit 0
fi

# Mock response for sf org auth show-sfdx-auth-url
if [[ "$*" == *"org auth show-sfdx-auth-url"* ]]; then
  cat <<'JSON'
{
  "status": 0,
  "result": {
    "sfdxAuthUrl": "force://PlatformCLI::EXAMPLE_MOCK_TOKEN_STRING_12345@simulated-scratch-domain-dev-ed.scratch.my.salesforce.com"
  }
}
JSON
  exit 0
fi

# Fallback for any other sf commands
exit 0
EOF
chmod +x "$MOCK_BIN/sf"

# 4. Setup mock GITHUB_STEP_SUMMARY
MOCK_SUMMARY="$TMP_DIR/github_step_summary.md"
export GITHUB_STEP_SUMMARY="$MOCK_SUMMARY"

echo -e "${YELLOW}ℹ️  Simulated Environment Active:${NC}"
echo -e "   - 'cci' calls are mocked (Org creation bypassed)"
echo -e "   - 'sf' CLI calls are mocked (Simulated JSON responses)"
echo -e "   - \$GITHUB_STEP_SUMMARY -> $MOCK_SUMMARY\n"

# 5. Extract bash script from .github/workflows/create-scratch-org.yml
WORKFLOW_FILE=".github/workflows/create-scratch-org.yml"
if [ ! -f "$WORKFLOW_FILE" ]; then
  echo -e "${RED}❌ Workflow file $WORKFLOW_FILE not found!${NC}"
  rm -rf "$TMP_DIR"
  exit 1
fi

echo -e "🔍 Extracting script from ${WORKFLOW_FILE}..."
WORKFLOW_SCRIPT="$TMP_DIR/extracted_script.sh"

# Parse script block under 'Create Scratch Org, Run Dev Setup & Export Credentials'
awk '
  /name: Create Scratch Org, Run Dev Setup & Export Credentials/ { flag=1; next }
  flag && /run: \|/ { in_run=1; next }
  flag && in_run && /name:/ { flag=0; in_run=0 }
  flag && in_run { sub(/^          /, ""); print }
' "$WORKFLOW_FILE" > "$WORKFLOW_SCRIPT"

if [ ! -s "$WORKFLOW_SCRIPT" ]; then
  echo -e "${RED}❌ Failed to extract script from workflow file.${NC}"
  rm -rf "$TMP_DIR"
  exit 1
fi

chmod +x "$WORKFLOW_SCRIPT"

# 6. Execute extracted workflow script in test environment
echo -e "⚙️  Executing extracted workflow script..."
(cd "$TMP_DIR" && bash "$WORKFLOW_SCRIPT" >/dev/null 2>&1)

TEST_MD="$TMP_DIR/scratch_org_credentials.md"

if [ ! -f "$TEST_MD" ]; then
  echo -e "${RED}❌ Validation Failed: scratch_org_credentials.md was not generated!${NC}"
  rm -rf "$TMP_DIR"
  exit 1
fi

echo -e "${GREEN}✅ Script executed successfully. Validating output formatting...${NC}\n"

# 7. Run validations on generated markdown file
ERRORS=0

# Check for ANSI escape sequences (\x1b or ␛)
if LC_ALL=C grep -q $'[\x1b]' "$TEST_MD" || grep -q '␛' "$TEST_MD"; then
  echo -e "${RED}❌ Validation Error: ANSI escape sequences detected in markdown!${NC}"
  ERRORS=$((ERRORS + 1))
else
  echo -e "${GREEN}  ✓ Clean output: No ANSI escape sequences found${NC}"
fi

# Check required sections
for SECTION in "Org Information" "CLI Auth Token" "How to Authenticate"; do
  if ! grep -q "$SECTION" "$TEST_MD"; then
    echo -e "${RED}❌ Validation Error: Section '$SECTION' missing from markdown!${NC}"
    ERRORS=$((ERRORS + 1))
  else
    echo -e "${GREEN}  ✓ Found section: '$SECTION'${NC}"
  fi
done

# Check required fields in Org Info table
for FIELD in "Alias" "Status" "Org Name" "Org ID" "Username" "Password" "Instance URL" "API Version" "Created Date" "Expire Date"; do
  if ! grep -q "\*\*$FIELD\*\*" "$TEST_MD"; then
    echo -e "${RED}❌ Validation Error: Field '$FIELD' missing in Org Info table!${NC}"
    ERRORS=$((ERRORS + 1))
  else
    echo -e "${GREEN}  ✓ Found table field: '$FIELD'${NC}"
  fi
done

# Check SFDX Auth URL format
if grep -q "force://" "$TEST_MD"; then
  echo -e "${GREEN}  ✓ Valid SFDX Auth URL format ('force://...') present${NC}"
else
  echo -e "${RED}❌ Validation Error: SFDX Auth URL ('force://...') not found!${NC}"
  ERRORS=$((ERRORS + 1))
fi

# Check CLI login instructions
if grep -q "sf org login sfdx-url" "$TEST_MD"; then
  echo -e "${GREEN}  ✓ CLI login command instructions present${NC}"
else
  echo -e "${RED}❌ Validation Error: CLI login instructions missing!${NC}"
  ERRORS=$((ERRORS + 1))
fi

echo ""
if [ $ERRORS -eq 0 ]; then
  echo -e "${GREEN}====================================================${NC}"
  echo -e "${GREEN}🎉 ALL PIPELINE TESTS PASSED LOCALLY!               ${NC}"
  echo -e "${GREEN}====================================================${NC}\n"
  echo -e "📄 Simulated Output Preview:"
  echo -e "----------------------------------------------------"
  cat "$TEST_MD"
  echo -e "----------------------------------------------------\n"
  rm -rf "$TMP_DIR"
  exit 0
else
  echo -e "${RED}====================================================${NC}"
  echo -e "${RED}❌ $ERRORS PIPELINE VALIDATION ERRORS DETECTED        ${NC}"
  echo -e "${RED}====================================================${NC}\n"
  rm -rf "$TMP_DIR"
  exit 1
fi
