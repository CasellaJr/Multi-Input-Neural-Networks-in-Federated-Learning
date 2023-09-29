#!/bin/bash

#subjectlist=$PWD/subjects.txt
#numjobs=8
path_ADNI=/home/nuc3/Scrivania/ADNI3/data
current=`pwd`



function organize_dirs {
    
    subj=$1
    dicom=$subj/dicom
    
    # Move all current folders within "Dicom" dir
    subj_files=`ls $subj`;              # Get list of current dirs
    
    if ! [ -d "$dicom" ]; then
        mkdir -p $dicom;
        for file in $subj_files; do echo "$file" && mv $subj/$file $dicom; done  
    fi
    
    # Create nifti subidir if it doesn't exists
    if ! [ -d "$nifti" ]; then
        nifti=$subj/nifti && mkdir -p $nifti;
    fi
}


function setup_data {

    subj_path=$1

    dicom_path=$subj_path/dicom
    nifti_path=$subj_path/nifti
    
    echo "dicom $dicom_path nifti $nifti_path"
    
    accel_found=0;
    
    for acq_type in $(ls $dicom_path);
    do
        acq_date=`ls $dicom_path/$acq_type/ | head -1 | tail -1`
        acq_id=`ls $dicom_path/$acq_type/$acq_date/ | tail -1`
        
    
        # Create dest dir to store matlab conversion
        matlab_out=$nifti_path/$acq_type
        if ! [ -d "$matlab_out" ]; then
            
            mkdir -p $matlab_out;
            matlab_in=$dicom_path/$acq_type/$acq_date/$acq_id
            #echo "converto $matlab_in in $matlab_out"
            #echo "ricordo che type=$acq_type, date=$acq_date e id=$acq_id"
            matlab -nodisplay -nosplash -nodesktop -r "cd /home/nuc3/Documenti/phd/; converter('$matlab_in/','$matlab_out/'); exit" 
            
            echo $acq_type
            if [[ "$acq_type" == *"Accel"* ]]; then
                mv -u $matlab_out/*.nii.gz $matlab_out/$acq_type.nii.gz;
                fsl_anat -i $matlab_out/*.nii.gz -o $matlab_out/fsl_anat;
                accel_found=1;
            fi
            echo "--------------------------------------------------"
        fi     
    done
    if [ $accel_found -eq 0 ]
    then
        subj=$(basename "$subj_path");
        main_dir=$(dirname "$subj_path");
        echo $subj >> $main_dir/missing_accel.txt
    fi
}



export -f setup_data
cd $path_ADNI

FILE=$path_ADNI/missing_accel.txt
if [ -f "$FILE" ]; then
    rm $path_ADNI/missing_accel.txt
fi   

#for i in $(find $path_ADNI -type d);
for i in $(ls $path_ADNI);
do
    echo "Processing: $i";
    subj_path=$path_ADNI/$i;
    
    organize_dirs $subj_path
    setup_data $subj_path;
    
    echo "-------------------------------------------------------------";
done;

cd $current
