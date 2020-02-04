
workflow myWorkflow {
  call download_data
  call execute_casa
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

task execute_casa {
  File casaScript
  String scriptName = basename(casaScript)
  command {
    mv ${casaScript} ./${scriptName}
    casa --nologger --nogui -c ${scriptName}
  }
}
