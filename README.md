# Pod 1: Isolated Configuration - Complete Standalone Repository

## Overview
This is a **complete standalone repository** for running Experiment 5 - Pod 1 (Isolated Configuration).

**Configuration**: Layers operate **independently** without coordination.

## What's Included

```
exp5_pod1_isolated/
├── run_pod1.sh                    ← Main execution script (RUN THIS!)
├── run_experiment5_coordination.py ← Experiment runner
├── validate_experiment5.py         ← Code validator
├── requirements.txt                ← Python dependencies
├── README.md                       ← This file
├── src/                           ← Source code
│   ├── config.py
│   ├── database.py
│   ├── experiment_runner.py
│   ├── pipeline.py                (coordination_enabled=False for this pod)
│   ├── statistical_analysis.py
│   ├── models/                    ← Data models
│   │   ├── __init__.py
│   │   ├── execution_trace.py
│   │   ├── layer_result.py
│   │   └── request.py
│   └── layers/                    ← Defense layers
│       ├── __init__.py
│       ├── layer1_boundary.py
│       ├── layer2_semantic.py
│       ├── layer3_context.py
│       ├── layer4_llm.py
│       └── layer5_output.py
├── data/                          ← Attack prompts
│   └── attack_prompts.py          (52 attacks)
└── results/                       ← Output directory
    └── (exp5_isolated.db will be created here)
```

## Quick Start (3 Commands)

### 1. Install Dependencies
```bash
pip install -r requirements.txt
```

### 2. Setup Ollama & llama3 Model
```bash
# Install Ollama (if not already installed)
curl -fsSL https://ollama.ai/install.sh | sh

# Start Ollama service
ollama serve &

# Pull llama3 model (takes 5-10 minutes)
ollama pull llama3
```

### 3. Run Experiment
```bash
bash run_pod1.sh
```

**That's it!** The script will:
- Install dependencies
- Validate code structure
- Run 260 experiments (52 attacks × 5 trials)
- Save results to `results/exp5_isolated.db`
- Generate summary JSON

## Configuration Details

| Setting | Value |
|---------|-------|
| Config name | `isolated` |
| Coordination | **DISABLED** (False) |
| Layers enabled | All 5 layers |
| Isolation mode | `good` (role-based) |
| Expected traces | 260 |
| Runtime | ~45 minutes |
| Cost | ~$0.66 |

## What Gets Tested

**Baseline Defense** (No Coordination):
- Layer 1: Boundary validation (independent)
- Layer 2: Semantic analysis (independent)
- Layer 3: Context isolation (mode="good", no adaptive escalation)
- Layer 4: LLM interaction (no enhanced monitoring)
- Layer 5: Output validation (default threshold)

**No information sharing** between layers = baseline performance.

## Output Files

After completion, you'll have:

### 1. `results/exp5_isolated.db`
SQLite database with 260 execution traces, including:
- `propagation_path` - Layer-by-layer decisions
- `trust_boundary_violations` - Privilege escalation attempts
- `coordination_enabled` - False for all traces
- `coordination_context` - Empty (no coordination)

### 2. `results/exp5_isolated_summary.json`
```json
{
  "experiment": "exp5_coordination",
  "config": "isolated",
  "coordination_enabled": false,
  "total_traces": 260,
  "successful_attacks": <number>,
  "blocked_attacks": <number>,
  "attack_success_rate": <percentage>,
  "elapsed_time_seconds": <time>
}
```

## Download These Files

After experiment completes, download:
1. **results/exp5_isolated.db** (2-5 MB)
2. **results/exp5_isolated_summary.json** (< 1 KB)

Compare with Pod 2 (coordinated) to measure coordination effectiveness.

## Troubleshooting

### Validation Fails
```bash
python3 validate_experiment5.py
# Check which components are missing
```

### Missing Dependencies
```bash
pip install pydantic openai anthropic python-dotenv
```

### Slow Execution
- Check GPU: `nvidia-smi`
- Reduce trials: edit `run_pod1.sh` and change `--trials 5` to `--trials 3`

### Out of Memory
- Restart pod with more RAM
- Check processes: `ps aux | grep python`

## Manual Execution

If you prefer not to use the script:

```bash
python3 run_experiment5_coordination.py \
    --config isolated \
    --output results/exp5_isolated.db \
    --trials 5
```

## System Requirements

- Python 3.8+
- 8GB+ RAM recommended
- GPU optional (speeds up LLM calls)
- 5GB disk space
- Internet connection (for LLM API calls)

## Environment Variables

Required:
- `OPENAI_API_KEY` - For GPT-4 API access

Or alternatively:
- `ANTHROPIC_API_KEY` - For Claude API access

Set in your shell or create `.env` file:
```bash
export OPENAI_API_KEY="your-key-here"
```

## Expected Runtime Breakdown

- Setup & validation: ~2 minutes
- Experiment execution: ~43 minutes
  - Per attack: ~50 seconds
  - Per trial: ~10 seconds
- Total: ~45 minutes

## Next Steps

1. **Run this pod** (Pod 1: isolated)
2. **Run Pod 2** (coordinated) - **simultaneously** if possible
3. **Download results** from both pods
4. **Compare ASR**: isolated vs coordinated
5. **Statistical analysis**: McNemar's test, effect size

---

**Repository**: Standalone (all code included)  
**Status**: Ready to run  
**Support**: Check parent README or EXPERIMENT5_DEPLOYMENT.md
