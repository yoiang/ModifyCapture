import processing.video.*;
Capture myCapture;
PImageEX CaptureFrame, LastFrame, DifferenceFrame;
int Threshhold;
ArrayList DifferenceModifiers;
int CurrentModifierIndex;

void setup() 
{
  size(600, 480);
  
  Threshhold = 50;

  String[] cameras = Capture.list();
  if ( cameras.length > 0 )
  {
    myCapture = new Capture(this, cameras[0]);
    myCapture.start();
  } else
  {
  }

  // The name of the capture device is dependent those
  // plugged into the computer. To get a list of the 
  // choices, uncomment the following line 
  // println(Capture.list());
  // And to specify the camera, replace "Camera Name" 
  // in the next line with one from Capture.list()
  // myCapture = new Capture(this, width, height, "Camera Name", 30);
  CaptureFrame = new PImageEX( width, height, RGB );
  CaptureFrame.loadPixels();
  LastFrame = new PImageEX( width, height, RGB );
  LastFrame.loadPixels();
  DifferenceFrame = new PImageEX( width, height, RGB );
  DifferenceFrame.loadPixels();
  
  DifferenceModifiers = new ArrayList();
  DifferenceModifiers.add( new meltDifference() );
  DifferenceModifiers.add( new meltDifferenceBidirectional() );
  DifferenceModifiers.add( new markDifference() );
  DifferenceModifiers.add( new meltDifferenceSolidColor() );
  DifferenceModifiers.add( new shiftDifferenceColumn() );
  CurrentModifierIndex = 0;
  println("Starting with " + (( DifferenceModifier )DifferenceModifiers.get( CurrentModifierIndex ) ).ToString() );
}

void draw() {
  if(keyPressed) {
    if(key == '-' ) {
      if ( Threshhold > 0 )
      {          
        Threshhold -= 1;
      }
    } else if( key == '=' )
    {
      if ( Threshhold < 255 * 3 )
      {          
        Threshhold += 1;
      }
    } else if ( key == ' ' )
    {
      CurrentModifierIndex ++;
      if ( CurrentModifierIndex >= DifferenceModifiers.size() )
      {
        CurrentModifierIndex = 0;
      }
      println("Switching to " + (( DifferenceModifier )DifferenceModifiers.get( CurrentModifierIndex ) ).ToString() );
    }
  }

  LastFrame.copy( CaptureFrame, 0, 0, CaptureFrame.width, CaptureFrame.height, 0, 0, LastFrame.width, LastFrame.height );
  LastFrame.updatePixels();

  myCapture.read();
  myCapture.updatePixels();
  
  CaptureFrame.copy( myCapture, 0, 0, myCapture.width, myCapture.height, 0, 0, CaptureFrame.width, CaptureFrame.height );
    
  DifferenceModifier CurrentModifier = (DifferenceModifier) DifferenceModifiers.get(CurrentModifierIndex);
  if( CurrentModifier != null )
  {
    CurrentModifier.doModify( LastFrame, CaptureFrame, DifferenceFrame, Threshhold );
  } else
  {
    println( "CurrentModifier (index " + CurrentModifierIndex + " in DifferenceModifiers) is null, exiting" );
    exit();
  }
  image(DifferenceFrame, 0, 0);
}
