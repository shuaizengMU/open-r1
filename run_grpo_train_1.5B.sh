#!/bin/bash
#-------------------------------------------------------------------------------
#  SBATCH CONFIG
#-------------------------------------------------------------------------------
#SBATCH -p requeue
#SBATCH -t 1-21:00
#SBATCH -N 1  # number of nodes
#SBATCH -n 8  # number of cores (AKA tasks)
#SBATCH --gres=gpu:A100:1
#SBATCH --mem=50G

## labels and outputs
#SBATCH -J Qwen1.5B  # give the job a custom name
#SBATCH -o ./stdout/Qwen-1.5B.out  # give the job output a custom name

#-------------------------------------------------------------------------------

# DS_BUILD_CPU_ADAM=1  BUILD_UTILS=1  pip install deepspeed -U
source ~/data/anaconda3/bin/activate ~/data/anaconda3/envs/env_rl
# export CUDA_VISIBLE_DEVICES=0,1

ACCELERATE_LOG_LEVEL=info accelerate launch --config_file recipes/accelerate_configs/zero2_offload_cpu.yaml \
    src/open_r1/grpo_ctm.py --config recipes/Qwen2.5-1.5B-Instruct/grpo/config_demo.yaml


# sleep 259200 