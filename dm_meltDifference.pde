class meltDifference extends DifferenceModifier
{
  public String ToString()
  {
    return "Melt Difference";
  }
  public void doModify( PImageEX A, PImageEX B, PImageEX Result, int Threshhold )
  {
    Result.copy( myCapture, 0, 0, B.width, B.height, 0, 0, Result.width, Result.height );
    Result.updatePixels();

    color ColorA, ColorB, setValue;
    int Distance, ARed = 0, AGreen = 0, ABlue = 0, BRed = 0, BGreen = 0, BBlue = 0, DRed = 0, DGreen = 0, DBlue = 0;
    for( int TravWidth = 0; TravWidth < A.width; TravWidth++ )
    {
      for( int TravHeight = 0; TravHeight < A.height; TravHeight++ )
      {
        ColorA = A.get( TravWidth, TravHeight );
        ColorB = B.get( TravWidth, TravHeight );
        if ( ColorA != ColorB )
        {
          ARed = int( (ColorA >> 16 ) & 0xFF );
          AGreen = int( (ColorA >> 8 ) & 0xFF );
          ABlue = int( ColorA & 0xFF );
          BRed = int( (ColorB >> 16 ) & 0xFF );
          BGreen = int( (ColorB >> 8 ) & 0xFF );
          BBlue = int( ColorB & 0xFF );

          Distance = abs( ARed - BRed ) + abs( AGreen - BGreen ) + abs( ABlue - BBlue );
          if ( Distance >= Threshhold )
          {
            int distancedDistance = Distance / 510;
            for( int meltY = A.height; meltY > TravHeight; meltY -- )
            {
              setValue = Result.get( TravWidth, meltY );
              DRed = int( (setValue >> 16 ) & 0xFF );
              DGreen = int( (setValue >> 8 ) & 0xFF );
              DBlue = int( setValue & 0xFF );
              Result.set( TravWidth, meltY + 1, color(DRed, DGreen, DBlue, distancedDistance ) );
            }
          }
        }
      }
    }
    Result.updatePixels();
  }
}

