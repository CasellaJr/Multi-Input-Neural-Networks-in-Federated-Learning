# Multi-Input-Neural-Networks-in-Federated-Learning

This repository contains the code used to train a Multi-Input Neural Network (NN) in a centralized (standard Deep Learning) and in a federated setting using [PyTorch](https://pytorch.org/) and the Intel [OpenFL](https://openfl.readthedocs.io/en/latest/index.html) framework. Our proposed Multi-Input NN consists of a [ResNet-18](https://pytorch.org/vision/main/models/generated/torchvision.models.resnet18.html) concatenated with a Multilayer Perceptron (MLP).

Extensive experiments have been executed in a centralized and in a federated scenarios, testing a Multi-Input NN with a ResNet-18 or with an MLP, over two datasets:
- [CoViD-19 CXR](https://ai4covid-hackathon.it/), trained on the [HPC4AI](https://hpc4ai.unito.it/documentation/) cluster at the University of Turin (node: 8 cores per CPU, AMD EPYC-IPBP, 1 NVIDIA A40 GPU));
- [ADNI](https://adni.loni.usc.edu/), trained on a 4 nodes cluster of dual socket machines equipped with Intel(R) Xeon(R) Platinum 8380 CPU @2.30GHz, with 40 physical cores per socket.

## Usage

To run the experiment as is, clone [this]([https://github.com/alpha-unito/streamflow-fl](https://github.com/CasellaJr/Multi-Input-Neural-Networks-in-Federated-Learning)) repository and use the following:
For CoViD-19 CXR dataset in centralized version:
- ```
  1. Put in the folder "CENTRALIZED EXPERIMENTS" the excel 'trainANDtest.xls', and the folder "DATASET", that contains the images.
  2. Run all the cells of the notebooks (Multi-input, only images and only text).
  ```
For CoViD-19 CXR dataset in federated version:
- ```
  1. Install [OpenFL](https://openfl.readthedocs.io/en/latest/index.html)
  2. Put in the folder "FEDERATED EXPERIMENTS" the excel 'trainANDtest.xls', and the folder "DATASET", that contains the images.
  3. Open a terminal for the director and one for each envoy.
  4. `./start_director.sh`
  5. `./start_envoy.sh`
  6. Run all the cells of the notebook in the workspace.
  7. For reproducibility, do 5 runs changing the variable `myseed` from 0 to 4 and then calculate mean and standard deviation of the best aggregated model.
  ```
- For ADNI dataset in centralized version:
- ```
  1. Create the ADNI_ready.csv and ADNIx_paths.pkl as specified in the img-only and multi-input examples (the file is the same and can be reused).
  2. Create the ADNI_extracted.csv as specified in the txt-only and multi-input examples (the file is the same and can be reused), to run the text based experiments.
  3. Place the csv files in a dir called "ADNI_csv"
  4. Place the the ADNIx_paths.pkl in a folder called "ax" where x is the number of ADNI dataset (i.e. a1, for ADNI1). Each ADNI set must have its own paths.pkl file as described in the notebooks.
  5. Once all the files are in place, run the notebooks. Explanations of what each cell performs are reported in the notebook itself.
  6. To allow cross-test evaluation, execute the cell to store the test dataset and manually clone the test-set of each ADNI into the respective folders (as described in each notebook).
  ```
- For ADNI dataset in federated version:
- ```
  1. Make sure that all the files required to run the CENTRALIZED settings have already been generated.
  2. Create the ADNI_extracted.csv as specified in the txt-only and multi-input examples (the file is the same and can be reused), to run the text based experiments.
  3. Open a terminal for the director and one for each envoy.
  4. `./start_director.sh`
  5. `./start_envoy.sh`
  6. Run all the cells of the notebook in the workspace.
  7. For reproducibility, do 5 runs changing the variable `data_seed` (in the envoy_config.yaml) file from 0 to 4 and then calculate mean and standard deviation of the best aggregated model.
  8. For additional support and guidelines on how to spin-up a federated workload using Openfl, please consult the official repository: [here]([https://github.com/intel/openfl](https://github.com/intel/openfl))
  ```

## Contributors

Bruno Casella <bruno.casella@unito.it>  
Walter Riviera <walter.riviera@intel.com>  
Marco Aldinucci <marco.aldinucci@unito.it>  
Gloria Menegaz <gloria.menegaz@gmail.com>


