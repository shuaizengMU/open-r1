
ACCELERATE_LOG_LEVEL=info accelerate launch --config_file recipes/accelerate_configs/zero2.yaml \
    src/open_r1/sft.py \
    --config recipes/Qwen2.5-0.5B-Instruct/sft/config_demo.yaml