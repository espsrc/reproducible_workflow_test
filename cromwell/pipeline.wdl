
workflow myWorkflow {
  call create_folders
  call download_data
}

task create_folders {
  String output_folder
  command {
    mkdir -p ${output_folder}
  }
  output {
    File output_dir = "${output_folder}"
  }
}

task download_data {
  String wget_output
  command {
    wget -O ${wget_output} http://www.e-merlin.ac.uk/distribute/support/TEST1_L.fits
  }
  output {
    File downloaded_fits = "${wget_output}"
  }
}


