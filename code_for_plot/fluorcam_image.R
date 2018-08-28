# colorise greyscale FluorCam data

library(EBImage)
library(magick)

fs_fm <-
  paste0("~/Dropbox/2018/hokushin01/fluorcam_sampledata/sample/", c("fs_sample1.bmp", "fm_sample1.bmp")) %>%
  as.list %>%
  map(~ image_read(.) %>% as_EBImage %>% .@.Data %>% .[,,1])

fluorcam <-
  pmax((fs_fm[[2]] - fs_fm[[1]]) / fs_fm[[2]] * (fs_fm[[2]] > 0.07), 0, na.rm = TRUE) %>%
  .[181:950,] %>%
  {
    rows <- nrow(.)
    if_else(. == 0, as.numeric(NA), .) %>%
      matrix(nrow = rows) %>%
      return()
  }

if(1 == 2){
  cols = colorRamp(c("green", "black", "magenta"))
  png(filename = "~/Dropbox/Symp/IHC2018/slide/img/fluorcam.png", width = 800, height = 815)
  image(fluorcam, col = rgb(cols(0:99/99)/255), axes = FALSE, asp = 1)
  dev.off()
  
  fc <-
    readImage("~/Dropbox/Symp/IHC2018/slide/img/fluorcam.png")
}