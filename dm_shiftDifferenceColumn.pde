class shiftDifferenceColumn extends DifferenceModifier
{
  ArrayList DifferenceColumns;

  public String ToString()
  {
    if ( DifferenceColumns == null )
    {
      DifferenceColumns = new ArrayList();
    }
    return "Shift Difference Column";
  }
  public void doModify( PImageEX A, PImageEX B, PImageEX Result, int Threshhold )
  {
     int tempadempa = 0;
    while (DifferenceColumns.size() < A.width )
   {
     DifferenceColumns.add( tempadempa );
   }
    

    Result.copy( myCapture, 0, 0, B.width, B.height, 0, 0, Result.width, Result.height );
    Result.updatePixels();

    for ( int TravWidth = 0; TravWidth < A.width; TravWidth++ )
    {
      
      DifferenceColumns.set( TravWidth,  0);
    }

    for( int TravWidth = 0; TravWidth < A.width; TravWidth++ )
    {
      for( int TravHeight = 0; TravHeight < A.height; TravHeight++ )
      {
        color ColorA = A.get( TravWidth, TravHeight );
        color ColorB = B.get( TravWidth, TravHeight );
        if ( ColorA != ColorB )
        {
          int Distance, dRed, dGreen, dBlue;
          dRed = int( ( ColorA >> 16 ) & 0xFF ) - int( ( ColorB >> 16 ) & 0xFF );
          dGreen = int( ( ColorA >> 8 ) & 0xFF ) - int( ( ColorB >> 8 ) & 0xFF );
          dBlue = int( ColorA & 0xFF ) - int( ColorB & 0xFF );
          Distance = abs( dRed ) + abs( dGreen ) + abs( dBlue );
          if ( Distance >= Threshhold )
          {
            DifferenceColumns.set( TravWidth, (Integer)DifferenceColumns.get( TravWidth ) + 1 );
          }
        }
      }
    }
    for ( int TravWidth = 0; TravWidth < A.width; TravWidth++ )
    {
      if ( (Integer) DifferenceColumns.get( TravWidth ) != 0 )
      {
        for( int TravHeight = 0; TravHeight < A.height; TravHeight ++ )
        {
          Result.setWrapped( TravWidth, TravHeight + (Integer)DifferenceColumns.get( TravWidth ), B.get( TravWidth, TravHeight ) );
        }
      }
    }

    Result.updatePixels();
  }
}
