class meltDifferenceBidirectional extends DifferenceModifier
{
  public String ToString()
  {
    return "Melt Difference Bidirectional";
  }
  public void doModify( PImageEX A, PImageEX B, PImageEX Result, int Threshhold )
  {
    Result.copy( myCapture, 0, 0, B.width, B.height, 0, 0, Result.width, Result.height );
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
            int Distance, dRed, dGreen, dBlue;
            dRed = int( ( ColorB >> 16 ) & 0xFF ) - int( ( ColorA >> 16 ) & 0xFF );
            dGreen = int( ( ColorB >> 8 ) & 0xFF ) - int( ( ColorA >> 8 ) & 0xFF );
            dBlue = int( ColorB & 0xFF ) - int( ColorA & 0xFF );
            Distance = dRed + dGreen + dBlue;
            if ( abs( Distance ) >= Threshhold )
            {
              if ( Distance < 0 )
              {
                for( int meltY = 0; meltY < TravHeight; meltY ++ )
                {
                  Result.set( TravWidth, meltY - 1, Result.get( TravWidth, meltY ) );
                }
              } 
              else
              {
                for( int meltY = A.height; meltY > TravHeight; meltY -- )
                {
                  Result.set( TravWidth, meltY + 1, Result.get( TravWidth, meltY ) );
                }
              }
            }
          }

      }
    }
    Result.updatePixels();
  }
}

