
workflow myWorkflow {
  call download_data
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


