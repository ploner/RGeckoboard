geckoImagePrepare <- function(
  filePath,             # Full file path.
  size="1x1",           # Size in Geckoboard grid lines.
  retina=FALSE,         # If TRUE, duplicate the resolution.  
  device=jpeg,          # Graphics Device used. Available: PNG or JPEG. 
  adjustTitleRow=FALSE, # Should image be smaller for a title row?
  quality=100,          # For JPEG.
  ...                   # Additional parameters.
) {
  sizeCells <- as.numeric(strsplit(size, split="x")[[1]])
  sizes <- 240 * sizeCells - 10   # 230, 470, ...
  
  if(adjustTitleRow)
    sizes[2] <- sizes[2] - 30
  
  if(retina)
    sizes <- 2 * sizes
  
  if(adjustTitleRow && retina)
    sizes[2] <- sizes[2] - 30
  
  device(filePath, sizes[1], sizes[2], quality=100, ...)
  
  invisible(sizes)
}
