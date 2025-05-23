#!/bin/bash
#-------------------------------------------------------------------------------
#  SBATCH CONFIG
#-------------------------------------------------------------------------------
#SBATCH -p requeue
#SBATCH -t 0-21:00
#SBATCH -N 1  # number of nodes
#SBATCH -n 8  # number of cores (AKA tasks)
#SBATCH --gres=gpu:A100:1
#SBATCH --mem=24G

## labels and outputs
#SBATCH -J GRPOSer  # give the job a custom name
#SBATCH -o ./stdout/vllm-server.out  # give the job output a custom name

#-------------------------------------------------------------------------------

# module load cuda/11.8.0_gcc_9.5.0 
# source ~/data/anaconda3/bin/activate ~/data/anaconda3/envs/env_rl

# CUDA_VISIBLE_DEVICES=0 NCCL_DEBUG=WARN trl vllm-serve --model deepseek-ai/DeepSeek-R1-Distill-Qwen-7B
sleep 259200 