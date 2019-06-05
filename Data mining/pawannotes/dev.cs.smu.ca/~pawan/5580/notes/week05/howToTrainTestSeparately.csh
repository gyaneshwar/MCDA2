Rscript createTrainTestSet.r trainD.csv testD.csv
Rscript trainSaveRF.r trainD.csv resultsTrain.csv trainedRF.rda
Rscript loadTestRF.r testD.csv resultsTest.csv trainedRF.rda
