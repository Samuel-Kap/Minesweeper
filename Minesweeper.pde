import de.bezier.guido.*;
public final static int NUM_ROWS= 10;
public final static int NUM_COLS= 10;
private MSButton[][] buttons; //2d array of minesweeper buttons
private ArrayList <MSButton> mines= new ArrayList <MSButton>(); //ArrayList of just the minesweeper buttons that are mined

void setup ()
{
    size(400, 400);
    textAlign(CENTER,CENTER);
    Interactive.make( this );
     buttons = new MSButton[NUM_ROWS][NUM_COLS];
for(int r=0;r<NUM_ROWS;r++){
  for(int c=0; c<NUM_COLS;c++){
    buttons[r][c]= new MSButton(r,c);
  }
}
setMines();
}
public void setMines()
{
  int nM=(int)((Math.random()+1)*NUM_ROWS*2);
  int r;
  int c;
  for(int i=0;i<nM;i++){
  r= (int)(Math.random()*NUM_ROWS);
  c= (int)(Math.random()*NUM_ROWS);
    if(isValid(r,c)&&!mines.contains(buttons[r][c])){
       mines.add(buttons[r][c]);
       System.out.println(r+","+c);
    }
  }
}

public void draw ()
{
    background( 0 );
    if(isWon() == true)
        displayWinningMessage();
}
public boolean isWon()
{
    //your code here
    return false;
}
public void displayLosingMessage()
{
  System.out.println("you lose");
   for(int i=0; i<=NUM_ROWS;i++){
  for(int q =0;q <=NUM_COLS;q++){
     if(isValid(i,q)&&mines.contains(buttons[i][q])){
       buttons[i][q].mousePressed();
     }
    }
  }
}
public void displayWinningMessage()
{
    System.out.println("you win");
}
public boolean isValid(int r, int c)
{
 if (r>=0 && r<NUM_ROWS && c>=0 && c<NUM_COLS)
      return true;
    else
      return false;
}
public int countMines(int row, int col)
{
    int numMines = 0;
   for(int i=row-1; i<=row+1;i++){
  for(int q =col-1;q <=col+1;q++){
     if(isValid(i,q)&&mines.contains(buttons[i][q])){
       numMines++;
     }
    }
  }
  if(mines.contains(buttons[row][col]))
    numMines--;
    return numMines;
}
public class MSButton
{
    private int myRow, myCol;
    private float x,y, width, height;
    private boolean clicked, flagged;
    private String myLabel;
    
    public MSButton ( int row, int col )
    {
        width = 400/NUM_COLS;
        height = 400/NUM_ROWS;
        myRow = row;
        myCol = col; 
        x = myCol*width;
        y = myRow*height;
        myLabel = "";
        flagged = clicked = false;
        Interactive.add( this ); // register it with the manager
    }

    // called by manager
    public void mousePressed () 
    {
        
        if(mouseButton==RIGHT){
          flagged=!flagged;
        }else if(mines.contains(this)){
        clicked = true;
        displayLosingMessage();  
        }else if(countMines(myRow, myCol)>0){
          clicked = true;
         setLabel(countMines(myRow, myCol));
        }else{
          clicked = true;
           //8grid expance search recersive
        }
        
        if(isValid(myRow,myCol)&&buttons[myRow][myCol-1].isFlagged()){
      buttons[myRow][myCol-1].mousePressed();
        }
    
    }
    public void draw () 
    {    
        if (flagged)
            fill(0);
        else if( clicked && mines.contains(this) ) 
            fill(255,0,0);
        else if(clicked)
            fill( 200 );
        else 
            fill( 100 );

        rect(x, y, width, height);
        fill(0);
        text(myLabel,x+width/2,y+height/2);
    }
    public void setLabel(String newLabel)
    {
        myLabel = newLabel;
    }
    public void setLabel(int newLabel)
    {
        myLabel = ""+ newLabel;
    }
    public boolean isFlagged()
    {
        return flagged;
    }
}
