# MDM: Human Motion Diffusion Model

[arXiv](https://arxiv.org/abs/2209.14916)

The official PyTorch implementation of the paper **["Human Motion Diffusion Model"](https://arxiv.org/abs/2209.14916)**.

Please visit our **[webpage](https://guytevet.github.io/mdm-page/)** for more details.

teaser

## MDM is now 40X faster 🤩🤩🤩 (~0.4 sec/sample)

### How come?!?

(1) We released the [50 diffusion steps model](https://drive.google.com/file/d/1cfadR1eZ116TIdXK7qDX1RugAerEiJXr/view?usp=sharing) (instead of 1000 steps) which runs 20X faster with comparable results.

(2) [Calling CLIP just once and caching the result](https://github.com/GuyTevet/motion-diffusion-model/commit/94c173ff8bb11362e45dd9262751f07bf9293660) runs 2X faster for all models. Please pull.

## MDM results on *HumanML3D* to cite in your paper (The original model used in the MDM paper)

Performance improvement is due to an evaluation bug fix. BLUE marks fixed entries compared to the paper.
fixed_results

- You can use [this](assets/fixed_results.tex) `.tex` file.
- The fixed **KIT** results are available [here](https://github.com/GuyTevet/motion-diffusion-model/issues/211#issue-2369160290).

## [NEW] DiP: Ultra-fast Text-to-motion

### DiP is now part of the MDM code base!

### [Here's how to use it](DiP.md)

DiP

## Bibtex

If you find this code useful in your research, please cite:

```
MDM:

@inproceedings{
tevet2023human,
title={Human Motion Diffusion Model},
author={Guy Tevet and Sigal Raab and Brian Gordon and Yoni Shafir and Daniel Cohen-or and Amit Haim Bermano},
booktitle={The Eleventh International Conference on Learning Representations },
year={2023},
url={https://openreview.net/forum?id=SJ1kSyO2jwu}
}

DiP and CLoSD:

@article{tevet2024closd,
  title={CLoSD: Closing the Loop between Simulation and Diffusion for multi-task character control},
  author={Tevet, Guy and Raab, Sigal and Cohan, Setareh and Reda, Daniele and Luo, Zhengyi and Peng, Xue Bin and Bermano, Amit H and van de Panne, Michiel},
  journal={arXiv preprint arXiv:2410.03441},
  year={2024}
}
```

## News

📢 **12/Feb/25** - Added many things:

- [The DiP model](DiP.md)
- MDM with DistilBERT text encoder (Add `--text_encoder_type bert`)
  - Developed by the legendary [Roy Kapon](https://scholar.google.com/citations?user=FAQOuSgAAAAJ&hl=en)!
- `--gen_during_training` feature.
- `--mask_frames` bug fix.
- `--use_ema` Weight averaging using Exponential Moving Average.
- Dataset caching for faster loading (by default).
- `eval_humanml` script can be logged with WanDB.

📢 **29/Jan/25** - Added WandB support with `--train_platform_type WandBPlatform`.

📢 **15/Apr/24** - Released a [50 diffusion steps model](https://drive.google.com/file/d/1cfadR1eZ116TIdXK7qDX1RugAerEiJXr/view?usp=sharing) (instead of 1000 steps) which runs 20X faster 🤩🤩🤩 with comparable results.

📢 **12/Apr/24** - MDM inference is now 2X faster 🤩🤩🤩 This was made possible by [calling CLIP just once and caching the result](https://github.com/GuyTevet/motion-diffusion-model/commit/94c173ff8bb11362e45dd9262751f07bf9293660), and is backward compatible with older models.

📢 **25/Jan/24** - Fixed bug in evalutation code (#182) - Please use the fixed results when citing MDM.  

📢 **1/Jun/23** - Fixed generation issue (#104) - Please pull to improve generation results.

📢 **23/Nov/22** - Fixed evaluation issue (#42) - Please pull and run `bash prepare/download_t2m_evaluators.sh` from the top of the repo to adapt.

📢 **4/Nov/22** - Added sampling, training and evaluation of unconstrained tasks.
  Note slight env changes adapting to the new code. If you already have an installed environment, run `bash prepare/download_unconstrained_assets.sh; conda install -y -c anaconda scikit-learn`  to adapt.

📢 **3/Nov/22** - Added in-between and upper-body editing.

📢 **31/Oct/22** - Added sampling, training and evaluation of action-to-motion tasks.

📢 **9/Oct/22** - Added training and evaluation scripts. 
  Note slight env changes adapting to the new code. If you already have an installed environment, run `bash prepare/download_glove.sh; pip install clearml` to adapt.

📢 **6/Oct/22** - First release - sampling and rendering using pre-trained models.

## Checkout MDM Follow-ups (partial list)

🐔 [LoRA-MDM](https://haimsaw.github.io/LoRA-MDM/) - Promptly adapt MDM for stylized text-to-motion.

🦩 [AnyTop](https://anytop2025.github.io/Anytop-page/) - Character Animation Diffusion with Any Topology.

🥋 [CLoSD](https://guytevet.github.io/CLoSD-page/) - Real-time MDM controls the character in a physical simulation.

🐉 [SinMDM](https://sinmdm.github.io/SinMDM-page/) - Learns single motion motifs - even for non-humanoid characters.

👯 [PriorMDM](https://priormdm.github.io/priorMDM-page/) - Uses MDM as a generative prior, enabling new generation tasks with few examples or even no data at all.

💃 [MAS](https://guytevet.github.io/mas-page/) - Generating intricate 3D motions (including non-humanoid) using 2D diffusion models trained on in-the-wild videos.

🐒 [MoMo](https://monkeyseedocg.github.io/) - Monkey See, Monkey Do: Harnessing Self-attention in Motion Diffusion
for Zero-shot Motion Transfer

🏃 [CAMDM](https://github.com/AIGAnimation/CAMDM) - Taming Diffusion Probabilistic Models for Character Control - a real-time version of MDM.

## Getting started

This code was tested on `Ubuntu 18.04.5 LTS` and requires:

- Python 3.7
- conda3 or miniconda3
- CUDA capable GPU (one is enough)

### 1. Setup environment

**FFmpeg** is required for MP4 rendering (`moviepy`). Install it first.

**Linux / WSL**

```shell
sudo apt update && sudo apt install ffmpeg
conda env create -f environment.yml
conda activate mdm
python -m spacy download en_core_web_sm
pip install git+https://github.com/openai/CLIP.git
```

**Windows**

- **FFmpeg:** e.g. `winget install ffmpeg`, or follow a [Windows FFmpeg guide](https://www.geeksforgeeks.org/how-to-install-ffmpeg-on-windows/). It must be on `PATH` when you run `sample.generate`.
- **Conda env:** `environment.yml` is a Linux `conda env export` (pins Linux-only packages) and **will not install on Windows**. Use:
  ```powershell
  conda env create -f environment-windows.yml
  conda activate mdm
  ```
- **OpenAI CLIP:** Use the GitHub package only. Do **not** `pip install clip` (that is a different PyPI project and has no `clip.load`):
  ```powershell
  pip install git+https://github.com/openai/CLIP.git
  ```
- **spaCy English model:** `python -m spacy download en_core_web_sm` loads PyTorch via thinc; if `import torch` fails, install the model wheel directly (no CLI):
  ```powershell
  pip install https://github.com/explosion/spacy-models/releases/download/en_core_web_sm-3.3.0/en_core_web_sm-3.3.0-py3-none-any.whl
  ```
  Or from repo root: `powershell -ExecutionPolicy Bypass -File .\prepare\windows_install_en_core_web_sm.ps1`
- **PyTorch GPU DLL errors (e.g. WinError 182 on `import torch`):** Conda’s Windows CUDA DLLs often disagree with the driver. Prefer PyPI wheels:
  ```powershell
  conda remove -y pytorch torchvision torchaudio cudatoolkit --force
  pip uninstall -y torch torchvision torchaudio
  pip install torch==1.7.1+cu110 torchvision==0.8.2+cu110 torchaudio==0.7.2 -f https://download.pytorch.org/whl/torch_stable.html
  ```
  Helper script: `prepare\windows_reinstall_pytorch_cu110.ps1` (add `-CpuOnly` for CPU-only). Install [VC++ Redistributable x64](https://aka.ms/vs/17/release/vc_redist.x64.exe) if loading still fails.
- **BERT checkpoints (`text_encoder_type: bert`):** `pip install transformers==4.21.3` (newer `transformers` on **Python 3.7** can pull a `safetensors` build that fails on Windows). If Hugging Face downloads break with `MissingSchema` or odd `/api/...` URLs, clear bad hub env vars:
  ```powershell
  Remove-Item Env:HF_ENDPOINT -ErrorAction SilentlyContinue
  Remove-Item Env:HUGGINGFACE_HUB_URL -ErrorAction SilentlyContinue
  ```

**Optional Windows environment variables**

- `MDM_FORCE_CPU=1` — force CPU device (see `utils/dist_util.py`) when debugging CUDA hangs or DLL issues.
- `KMP_DUPLICATE_LIB_OK=TRUE` — if MP4 export dies with OpenMP “libomp / libiomp5” conflicts; `sample/generate.py` and `sample/edit.py` also set a safe default on Windows.

**Download assets (SMPL, GloVe, T2M evaluators) — Text to Motion**

Linux / Git Bash (from repo root; needs `gdown` or `python -m gdown`):

```bash
bash prepare/download_smpl_files.sh
bash prepare/download_glove.sh
bash prepare/download_t2m_evaluators.sh
```

Windows PowerShell (from repo root; `prepare/PrepareHelpers.ps1` resolves `gdown` / `python` / `py -3`):

```powershell
conda activate mdm
powershell -ExecutionPolicy Bypass -File .\prepare\download_smpl_files.ps1
powershell -ExecutionPolicy Bypass -File .\prepare\download_glove.ps1
powershell -ExecutionPolicy Bypass -File .\prepare\download_t2m_evaluators.ps1
```

In Git Bash, run `conda init bash` and open a new shell if `conda: command not found`.

**Action to Motion**

```bash
bash prepare/download_smpl_files.sh
bash prepare/download_recognition_models.sh
```

**Unconstrained**

```bash
bash prepare/download_smpl_files.sh
bash prepare/download_recognition_models.sh
bash prepare/download_recognition_unconstrained_models.sh
```

### 2. Get data

**Text to Motion** 

[Download HumanML3D](https://drive.google.com/drive/folders/1OZrTlAGRvLjXhXwnRiOC-oxYry1vf-Uu?usp=drive_link)

Or, alternatively, parse the data yourself according to the original instructions:

**Original Text to Motion instructions**

There are two paths to get the data:

(a) **Go the easy way if** you just want to generate text-to-motion (excluding editing which does require motion capture data)

(b) **Get full data** to train and evaluate the model.

#### a. The easy way (text only)

**HumanML3D** - Clone HumanML3D, then copy the data dir to our repository:

```shell
cd ..
git clone https://github.com/EricGuo5513/HumanML3D.git
unzip ./HumanML3D/HumanML3D/texts.zip -d ./HumanML3D/HumanML3D/
cp -r HumanML3D/HumanML3D motion-diffusion-model/dataset/HumanML3D
cd motion-diffusion-model
```

On Windows (PowerShell), from the parent folder that contains both clones (same layout as the shell commands above):

```powershell
Expand-Archive -Path .\HumanML3D\HumanML3D\texts.zip -DestinationPath .\HumanML3D\HumanML3D\ -Force
Copy-Item -Path .\HumanML3D\HumanML3D -Destination .\motion-diffusion-model\dataset\HumanML3D -Recurse
```

**Dataset folder layout:** After `cp -r ... ./dataset/HumanML3D`, captions are usually at `dataset/HumanML3D/texts/`. If you instead have `dataset/HumanML3D/HumanML3D/texts/` (extra nested folder), the loader detects that path automatically.

#### b. Full data (text + motion capture)

**HumanML3D** - Follow the instructions in [HumanML3D](https://github.com/EricGuo5513/HumanML3D.git),
then copy the result dataset to our repository:

```shell
cp -r ../HumanML3D/HumanML3D ./dataset/HumanML3D
```

**KIT** - Download from [HumanML3D](https://github.com/EricGuo5513/HumanML3D.git) (no processing needed this time) and the place result in `./dataset/KIT-ML`

**Action to Motion**

**UESTC, HumanAct12** 

```bash
bash prepare/download_a2m_datasets.sh
```

**Unconstrained**

**HumanAct12** 

```bash
bash prepare/download_unconstrained_datasets.sh
```

### Checkpoints, `args.json`, and generation output

- **`args.json` must sit next to each `model*.pt`** (same folder). Inference loads `dirname(model_path)/args.json`. If it is missing, copy the file bundled with the checkpoint download, or reuse the one from your training `save_dir`.
- **Match architecture to the weights:** CLIP models (e.g. [humanml-encoder-512](https://drive.google.com/file/d/1PE0PK8e5a5j-7-Xhs5YET5U5pGh0c821/view?usp=sharing)) use `trans_enc` + `text_encoder_type: clip`. BERT models (e.g. [humanml_trans_dec_512_bert-50steps](https://drive.google.com/file/d/1z5IW5Qa9u9UdkckKylkcSXCwIYgLPhIC/view?usp=sharing)) use `trans_dec` + `text_encoder_type: bert`. A mismatched `args.json` causes state-dict errors (e.g. `embed_text` 768 vs 512).
- **Sampling output folder:** If `--output_dir` is empty, results go under `dirname(model_path)/samples_<ckpt_folder>_<step>_seed<seed>/`. That directory contains `results.npy`, `results.txt`, `results_len.txt`, and MP4s such as `samples_00_to_02.mp4`. The script prints `[Done] Results are at [...]` when finished.
- **Windows DataLoader:** `data_loaders/get_data.py` uses `num_workers=0` on Windows to avoid multiprocessing deadlocks.

### 3. Download the pretrained models

Download the model(s) you wish to use, then unzip and place them in `./save/`. 

**Text to Motion**

**You need only the first one.** 

**HumanML3D**

[NEW!] [humanml_trans_dec_512_bert-50steps](https://drive.google.com/file/d/1z5IW5Qa9u9UdkckKylkcSXCwIYgLPhIC/view?usp=sharing) - Runs 20X faster with improved precision!

[NEW!] [humanml-encoder-512-50steps](https://drive.google.com/file/d/1cfadR1eZ116TIdXK7qDX1RugAerEiJXr/view?usp=sharing) - Runs 20X faster with comparable performance!

[humanml-encoder-512](https://drive.google.com/file/d/1PE0PK8e5a5j-7-Xhs5YET5U5pGh0c821/view?usp=sharing) (best model used in the paper)

[humanml-decoder-512](https://drive.google.com/file/d/1q3soLadvVh7kJuJPd2cegMNY2xVuVudj/view?usp=sharing)

[humanml-decoder-with-emb-512](https://drive.google.com/file/d/1GnsW0K3UjuOkNkAWmjrGIUmeDDZrmPE5/view?usp=sharing)

**KIT**

[kit-encoder-512](https://drive.google.com/file/d/1SHCRcE0es31vkJMLGf9dyLe7YsWj7pNL/view?usp=sharing)

**Action to Motion**

**UESTC**

[uestc](https://drive.google.com/file/d/1goB2DJK4B-fLu2QmqGWKAqWGMTAO6wQ6/view?usp=sharing)

[uestc_no_fc](https://drive.google.com/file/d/1fpv3mR-qP9CYCsi9CrQhFqlLavcSQky6/view?usp=sharing)

**HumanAct12**

[humanact12](https://drive.google.com/file/d/154X8_Lgpec6Xj0glEGql7FVKqPYCdBFO/view?usp=sharing)

[humanact12_no_fc](https://drive.google.com/file/d/1frKVMBYNiN5Mlq7zsnhDBzs9vGJvFeiQ/view?usp=sharing)

**Unconstrained**

**HumanAct12**

[humanact12_unconstrained](https://drive.google.com/file/d/1uG68m200pZK3pD-zTmPXu5XkgNpx_mEx/view?usp=share_link)

## Motion Synthesis

**Text to Motion**

### Generate from test set prompts

```shell
python -m sample.generate --model_path ./save/humanml_trans_enc_512/model000200000.pt --num_samples 10 --num_repetitions 3
```

### Generate from your text file

```shell
python -m sample.generate --model_path ./save/humanml_trans_enc_512/model000200000.pt --input_text ./assets/example_text_prompts.txt
```

### Generate a single prompt

```shell
python -m sample.generate --model_path ./save/humanml_trans_enc_512/model000200000.pt --text_prompt "the person walked forward and is picking up his toolbox."
```

**Action to Motion**

### Generate from test set actions

```shell
python -m sample.generate --model_path ./save/humanact12/model000350000.pt --num_samples 10 --num_repetitions 3
```

### Generate from your actions file

```shell
python -m sample.generate --model_path ./save/humanact12/model000350000.pt --action_file ./assets/example_action_names_humanact12.txt
```

### Generate a single action

```shell
python -m sample.generate --model_path ./save/humanact12/model000350000.pt --action_name "drink"
```

**Unconstrained**

```shell
python -m sample.generate --model_path ./save/unconstrained/model000450000.pt --num_samples 10 --num_repetitions 3
```

By abuse of notation, (num_samples * num_repetitions) samples are created, and are visually organized in a display of num_samples rows and num_repetitions columns.

**You may also define:**

- `--device` id.
- `--seed` to sample different prompts.
- `--motion_length` (text-to-motion only) in seconds (maximum is 9.8[sec]).

**Running those will get you:**

- `results.npy` file with text prompts and xyz positions of the generated animation
- `sample##_rep##.mp4` - a stick figure animation for each generated motion.

It will look something like this:

example

You can stop here, or render the SMPL mesh using the following script.

### Render SMPL mesh

To create SMPL mesh per frame run:

```shell
python -m visualize.render_mesh --input_path /path/to/mp4/stick/figure/file
```

**This script outputs:**

- `sample##_rep##_smpl_params.npy` - SMPL parameters (thetas, root translations, vertices and faces)
- `sample##_rep##_obj` - Mesh per frame in `.obj` format.

**Notes:**

- The `.obj` can be integrated into Blender/Maya/3DS-MAX and rendered using them.
- This script is running [SMPLify](https://smplify.is.tue.mpg.de/) and needs GPU as well (can be specified with the `--device` flag).
- **Important** - Do not change the original `.mp4` path before running the script.

**Notes for 3d makers:**

- You have two ways to animate the sequence:
  1. Use the [SMPL add-on](https://smpl.is.tue.mpg.de/index.html) and the theta parameters saved to `sample##_rep##_smpl_params.npy` (we always use beta=0 and the gender-neutral model).
  2. A more straightforward way is using the mesh data itself. All meshes have the same topology (SMPL), so you just need to keyframe vertex locations.
    Since the OBJs are not preserving vertices order, we also save this data to the `sample##_rep##_smpl_params.npy` file for your convenience.

## Motion Editing

- This feature is available for text-to-motion datasets (HumanML3D and KIT).
- In order to use it, you need to acquire the full data (not just the texts).
- We support the two modes presented in the paper: `in_between` and `upper_body`.

### Unconditioned editing

```shell
python -m sample.edit --model_path ./save/humanml_trans_enc_512/model000200000.pt --edit_mode in_between
```

**You may also define:**

- `--num_samples` (default is 10) / `--num_repetitions` (default is 3).
- `--device` id.
- `--seed` to sample different prompts.
- `--edit_mode upper_body` For upper body editing (lower body is fixed).

The output will look like this (blue frames are from the input motion; orange were generated by the model):

example

- As in *Motion Synthesis*, you may follow the **Render SMPL mesh** section to obtain meshes for your edited motions.

### Text conditioned editing

Just add the text conditioning using `--text_condition`. For example:

```shell
python -m sample.edit --model_path ./save/humanml_trans_enc_512/model000200000.pt --edit_mode upper_body --text_condition "A person throws a ball"
```

The output will look like this (blue joints are from the input motion; orange were generated by the model):

example

## Train your own MDM

**Text to Motion**

**HumanML3D**

To reproduce the original paper model, run:

```shell
python -m train.train_mdm --save_dir save/my_humanml_trans_enc_512 --dataset humanml
```

To reproduce MDM-50 steps, Run:

```shell
python -m train.train_mdm --save_dir save/my_humanml_trans_enc_512_50steps --dataset humanml --diffusion_steps 50 --mask_frames --use_ema
```

To reproduce MDM+DistilBERT, Run:

```shell
python -m train.train_mdm --save_dir save/my_humanml_trans_dec_bert_512 --dataset humanml --diffusion_steps 50 --arch trans_dec --text_encoder_type bert --mask_frames --use_ema
```

**KIT**

```shell
python -m train.train_mdm --save_dir save/my_kit_trans_enc_512 --dataset kit
```

**Action to Motion**

```shell
python -m train.train_mdm --save_dir save/my_name --dataset {humanact12,uestc} --cond_mask_prob 0 --lambda_rcxyz 1 --lambda_vel 1 --lambda_fc 1
```

**Unconstrained**

```shell
python -m train.train_mdm --save_dir save/my_name --dataset humanact12 --cond_mask_prob 0 --lambda_rcxyz 1 --lambda_vel 1 --lambda_fc 1  --unconstrained
```

- **Recommended:** Add `--eval_during_training` and `--gen_during_training` to evaluate and generate motions for each saved checkpoint. 
This will slow down training but will give you better monitoring.
- **Recommended:** Add `--use_ema` for Exponential Moving Average, and `--mask_frames` to fix a masking bug. Both improve performance.
- Use `--diffusion_steps 50` to train the faster model with less diffusion steps.
- Use `--device` to define GPU id.
- Use `--arch` to choose one of the architectures reported in the paper `{trans_enc, trans_dec, gru}` (`trans_enc` is default).
- Use `--text_encoder_type` to choose the text encoder `{clip, bert}` (`clip` is default).
- Add `--train_platform_type {WandBPlatform, TensorboardPlatform}` to track results with either [WandB](https://wandb.ai/site/) or [Tensorboard](https://www.tensorflow.org/tensorboard).

## Evaluate

**Text to Motion**

- The output of this script for the pre-trained models (as was reported in the paper) is provided in the checkpoints zip file.

**HumanML3D**

```shell
python -m eval.eval_humanml --model_path ./save/humanml_trans_enc_512/model000475000.pt
```

**KIT**

```shell
python -m eval.eval_humanml --model_path ./save/kit_trans_enc_512/model000400000.pt
```

**Action to Motion**

- Takes about 7 hours for UESTC and 2 hours for HumanAct12 (on a single GPU)
- The output of this script for the pre-trained models (as was reported in the paper) is provided in the checkpoints zip file.

```shell
python -m eval.eval_humanact12_uestc --model <path-to-model-ckpt> --eval_mode full
```

where `path-to-model-ckpt` can be a path to any of the pretrained action-to-motion models listed above, or to a checkpoint trained by the user.

**Unconstrained**

- Takes about 3 hours (on a single GPU)

```shell
python -m eval.eval_humanact12_uestc --model ./save/unconstrained/model000450000.pt --eval_mode full
```

Precision and recall are not computed to save computing time. If you wish to compute them, edit the file eval/a2m/gru_eval.py and change the string `fast=True` to `fast=False`.

## Acknowledgments

This code is standing on the shoulders of giants. We want to thank the following contributors
that our code is based on:

[guided-diffusion](https://github.com/openai/guided-diffusion), [MotionCLIP](https://github.com/GuyTevet/MotionCLIP), [text-to-motion](https://github.com/EricGuo5513/text-to-motion), [actor](https://github.com/Mathux/ACTOR), [joints2smpl](https://github.com/wangsen1312/joints2smpl), [MoDi](https://github.com/sigal-raab/MoDi).

## License

This code is distributed under an [MIT LICENSE](LICENSE).

Note that our code depends on other libraries, including CLIP, SMPL, SMPL-X, PyTorch3D, and uses datasets that each have their own respective licenses that must also be followed.