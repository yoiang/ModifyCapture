class meltDifferenceSolidColor extends DifferenceModifier
{
  public String ToString()
  {
    return "Melt Difference Solid Color";
  }
  public void doModify( PImageEX A, PImageEX B, PImageEX Result, int Threshhold )
  {
    Result.copy( B, 0, 0, B.width, B.height, 0, 0, Result.width, Result.height );
    Result.updatePixels();

    for( int TravWidth = 0; TravWidth < A.width; TravWidth++ )
    {
      for( int TravHeight = 0; TravHeight < A.height; TravHeight++ )
      {
        color ColorA = A.get( TravWidth, TravHeight );
        color ColorB = B.get( TravWidth, TravHeight );
        if ( ColorA == ColorB )
        {
          Result.set( TravWidth, TravHeight, ColorA );
        } 
        else
        {
          int Distance, ARed, AGreen, ABlue, BRed, BGreen, BBlue;
          ARed = int( ( ColorA >> 16 ) & 0xFF );
          BRed = int( ( ColorB >> 16 ) & 0xFF );
          AGreen = int( ( ColorA >> 8 ) & 0xFF );
          BGreen = int( ( ColorB >> 8 ) & 0xFF );
          ABlue = int( ColorA & 0xFF );
          BBlue = int( ColorB & 0xFF );
          Distance = abs( ARed - BRed ) + abs( AGreen - BGreen ) + abs( ABlue - BBlue );
          if ( Distance >= Threshhold )
          {
            int distancedDistance = 510 / Distance;
            for( int meltY = A.height; meltY > TravHeight; meltY -- )
            {
              //              color setValue = Result.get( TravWidth, meltY );
              Result.set( TravWidth, meltY + 1, color(BRed, BGreen, BBlue, distancedDistance) );
            }
          }
        }
      }

    }
    Result.updatePixels();
  }
}


