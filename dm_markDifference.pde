class markDifference extends DifferenceModifier
{
  public String ToString()
  {
    return "Mark Difference";
  }
  public void doModify( PImageEX A, PImageEX B, PImageEX Result, int Threshhold )
  {

    for( int TravWidth = 0; TravWidth < A.width || TravWidth < B.width; TravWidth++ )
    {
      for( int TravHeight = 0; TravHeight < A.height || TravHeight < B.height; TravHeight++ )
      {
        color ColorA = A.get( TravWidth, TravHeight );
        color ColorB = B.get( TravWidth, TravHeight );
        if ( ColorA == ColorB )
        {
          Result.set( TravWidth, TravHeight, ColorA );
        } 
        else
        {
          int Distance, dRed, dGreen, dBlue;
          dRed = abs( ( ColorA >> 16 ) & 0xFF - ( ColorB >> 16 ) & 0xFF );
          dGreen = abs( ( ColorA >> 8 ) & 0xFF - ( ColorB >> 8 ) & 0xFF );
          dBlue = abs( ColorA & 0xFF - ColorB & 0xFF );
          Distance = dRed + dGreen + dBlue;
          if ( Distance < Threshhold )
          {
            Result.set( TravWidth, TravHeight, color( 0,0,0) );
//            Result.set( TravWidth, TravHeight, ColorB );            
          } 
          else
          {
            color SetValue = color( red(ColorB) * dRed, green(ColorB) * dGreen, blue(ColorB) * dBlue );
            Result.set( TravWidth, TravHeight, SetValue );
            //             Result.set( TravWidth, TravHeight, color(dRed, dGreen, dBlue ) );
          }
        }
      }
    }
    Result.updatePixels();
  }
}


