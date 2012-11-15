class PImageEX extends PImage
{
  public PImageEX( int Width, int Height, int Format )
  {
    PImage InitializeWith = createImage( Width, Height, Format );
    pixels = InitializeWith.pixels;
    width = Width;
    height = Height;
    format = Format;
  }
  
  public boolean checkHasPixel( int X, int Y )
  {
    if ( X < 0 || X >= this.width || Y < 0 || Y >= this.height )
    {
      return false;
    }
    return true;
  }
  
  public int normalizeX( int X )
  {
    int fixedX = X;
    while ( fixedX < 0 )
    {
      fixedX += this.width;
    }
    
    while( fixedX >= this.width )
    {
      fixedX -= this.width;
    }
    return fixedX;
  }
  
  public int normalizeY( int Y )
  {
    int fixedY = Y;
    while ( fixedY < 0 )
    {
      fixedY += this.height;
    }
    
    while( fixedY >= this.height )
    {
      fixedY -= this.height;
    }
    return fixedY;
  }
  
  public void setWrapped( int X, int Y, color Value )
  {
    int nX = normalizeX( X );
    int nY = normalizeY( Y );
    this.set( nX, nY, Value );
  }
  
  public color getWrapped( int X, int Y, color Value )
  {
    int nX = normalizeX( X );
    int nY = normalizeY( Y );
    return this.get( X, Y );
  }
  
  
}
