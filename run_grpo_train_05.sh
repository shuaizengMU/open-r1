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
#SBATCH -J Qwen0.5  # give the job a custom name
#SBATCH -o ./stdout/Qwen2.5-0.5B-Instruct  # give the job output a custom name

#-------------------------------------------------------------------------------

source ~/data/anaconda3/bin/activate ~/data/anaconda3/envs/env_rl

CUDA_VISIBLE_DEVICES=0 python src/open_r1/grpo_ctm.py --config recipes/Qwen2.5-0.5B-Instruct/grpo/config_demo.yaml