//Thanks paul Bourke, see http://paulbourke.net/geometry/pointlineplane/
//intersects returns true if segment edge from x1y1 to x2y2 intersects segment x3y3 to x4y4
//Here we interpret parallel lines as "not intersecting" (even if they are aligned) 
        
boolean intersects(float x1, float y1, float x2, float y2, float x3, float y3, float x4, float y4){
        float denominator =  ((y4 - y3)*(x2 - x1) - (x4 - x3)*(y2 - y1)); 
        if (denominator == 0) 
            return false;//better not divide by zero
        
        float ua = ((x4 - x3)*(y1 - y3) - (y4 - y3)*(x1 - x3)) / denominator;
        float ub = ((x2 - x1)*(y1 - y3) - (y2 - y1)*(x1 - x3)) / denominator;
        
        return 0 < ua && ua <= 1 
           &&  0 < ub && ub <= 1;
}
