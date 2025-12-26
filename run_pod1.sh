#!/bin/bash
# POD 1: Isolated Configuration (Baseline - No Coordination)
# This pod tests the defense system with layers operating INDEPENDENTLY

set -e

echo "╔════════════════════════════════════════════════════════════════╗"
echo "║       EXPERIMENT 5 - POD 1: ISOLATED (NO COORDINATION)        ║"
echo "╚════════════════════════════════════════════════════════════════╝"
echo ""
echo "Configuration: ISOLATED"
echo "  • Coordination: DISABLED (baseline)"
echo "  • Layers operate independently"
echo "  • No information sharing between layers"
echo "  • Expected traces: 260 (52 attacks × 5 trials)"
echo "  • Runtime: ~45 minutes"
echo ""

# Install dependencies
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "Step 1: Installing dependencies..."
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
pip install -q -r requirements.txt
echo "✓ Dependencies installed"
echo ""

# Validate code
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "Step 2: Validating code structure..."
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
python3 validate_experiment5.py

if [ $? -ne 0 ]; then
    echo "❌ VALIDATION FAILED! Check code structure."
    exit 1
fi
echo ""

# Run experiment
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "Step 3: Running Experiment 5 - ISOLATED Configuration"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "⏱️  Start time: $(date)"
echo ""

python3 run_experiment5_coordination.py \
    --config isolated \
    --output results/exp5_isolated.db \
    --trials 5

EXIT_CODE=$?
echo ""
echo "⏱️  End time: $(date)"
echo ""

# Check results
if [ $EXIT_CODE -eq 0 ]; then
    echo "╔════════════════════════════════════════════════════════════════╗"
    echo "║                  ✅ EXPERIMENT COMPLETE - POD 1                ║"
    echo "╚════════════════════════════════════════════════════════════════╝"
    echo ""
    echo "📦 Results Location:"
    echo "  • Database: results/exp5_isolated.db"
    echo "  • Summary:  results/exp5_isolated_summary.json"
    echo ""
    
    # Display summary if available
    if [ -f "results/exp5_isolated_summary.json" ]; then
        echo "📊 Experiment Summary:"
        echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
        cat results/exp5_isolated_summary.json
        echo ""
        echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    fi
    
    echo ""
    echo "📥 NEXT STEPS:"
    echo "  1. Download these 2 files from this pod:"
    echo "     • results/exp5_isolated.db"
    echo "     • results/exp5_isolated_summary.json"
    echo ""
    echo "  2. Wait for Pod 2 (coordinated) to complete"
    echo ""
    echo "  3. Compare results: isolated vs coordinated"
    echo ""
    
else
    echo "╔════════════════════════════════════════════════════════════════╗"
    echo "║                  ❌ EXPERIMENT FAILED - POD 1                  ║"
    echo "╚════════════════════════════════════════════════════════════════╝"
    echo ""
    echo "Exit code: ${EXIT_CODE}"
    echo "Check logs above for error details"
    exit ${EXIT_CODE}
fi
