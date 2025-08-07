# Initialize micromamba shell
eval "$(/dls/science/groups/i04-1/software/micromamba/bin/micromamba shell hook --shell=bash)"

# Activate your environment
micromamba activate xchem

# Source other environment scripts if needed
source /dls/science/groups/i04-1/software/XChem/xchempaths.sh
source /dls/science/groups/i04-1/software/pdb_extract_4.1/pdb-extract-prod-py-4.1/bin/setup.sh

#Install necessary softwares (should be done)
    #source /dls/science/groups/i04-1/software/XChem/xchempaths.sh (if not already in your ~/.bashrc_local)
    #micromamba-init
    #micromamba activate xchem
    #micromamba install six
    #micromamba install scikit-build
    #micromamba install cmake
    #micromamba install -c conda-forge mmcif_pdbx
    #pip install mmcif
    #source /dls/science/groups/i04-1/software/pdb_extract_4.1/pdb-extract-prod-py-4.1/bin/setup.sh
    #source /dls/science/groups/i04-1/software/pdb_extract_4.1/pdb-extract-prod-py-4.1/bin/install.sh
    #source /dls/science/groups/i04-1/software/pdb_extract_4.1/pdb-extract-prod-py-4.1/bin/updateDictionary.sh

#Shouldn't need to do the below, but if you do, run these commands before starting script
    #source /dls/science/groups/i04-1/software/XChem/xchempaths.sh (if not already in your ~/.bashrc_local)
    #micromamba-init
    #micromamba activate xchem
    #source /dls/science/groups/i04-1/software/pdb_extract_4.1/pdb-extract-prod-py-4.1/bin/setup.sh
    #/dls/science/groups/i04-1/software/pdb_extract_4.1/pdb-extract-prod-py-4.1/bin/pdb_extract.py

#Fill out the target list below with directories and crystal IDs

#create a variable called extraction_call
extraction_call="/dls/science/groups/i04-1/software/pdb_extract_4.1/pdb-extract-prod-py-4.1/bin/pdb_extract.py"

#list of datasets to target
datasets=( /dls/labxchem/data/lb27001/lb27001-39/processing/lb27001-17/processing/analysis/model_building/Mac1-x10181/
/dls/labxchem/data/lb27001/lb27001-39/processing/lb27001-17/processing/analysis/model_building/Mac1-x10183/
/dls/labxchem/data/lb27001/lb27001-39/processing/lb27001-17/processing/analysis/model_building/Mac1-x10184/
/dls/labxchem/data/lb27001/lb27001-39/processing/lb27001-17/processing/analysis/model_building/Mac1-x10199/
)

parent_directory="$(pwd)"
echo "$parent_directory is the working directory"

    for i in "${datasets[@]}" ; do 
        
        directory_name=$(basename "$i")
        
        echo "Working in $directory_name"

        cd "$i"
        $extraction_call -iCIF BUSTER_model.mmcif -e "MOLECULAR REPLACEMENT" -s AIMLESS "$directory_name".log -m PHASER -r BUSTER -iENT data_template.cif -o "$directory_name".mmcif > "$directory_name".mmcif.log

        echo "PDB extraction in $directory_name complete"
    done
    
exit
