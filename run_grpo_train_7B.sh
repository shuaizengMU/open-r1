#!/bin/bash
#-------------------------------------------------------------------------------
#  SBATCH CONFIG
#-------------------------------------------------------------------------------
#SBATCH --mem 40G
#SBATCH -n 1
#SBATCH --gres gpu:A100:2
#SBATCH --time 08-00:00:00 
#SBATCH -p xudong-gpu
#SBATCH -A xudong-lab

## labels and outputs
#SBATCH -J Qwen7B  # give the job a custom name
#SBATCH -o ./stdout/Qwen-7B.out  # give the job output a custom name

#-------------------------------------------------------------------------------

# DS_BUILD_CPU_ADAM=1  BUILD_UTILS=1  pip install deepspeed -U
source ~/data/anaconda3/bin/activate ~/data/anaconda3/envs/env_rl
# export CUDA_VISIBLE_DEVICES=0,1


ACCELERATE_LOG_LEVEL=info accelerate launch --config_file recipes/accelerate_configs/zero3_offload_disk.yaml \
    src/open_r1/grpo_ctm.py --config recipes/Qwen2.5-7B-Instruct/grpo/config_demo.yaml

sleep 259200 