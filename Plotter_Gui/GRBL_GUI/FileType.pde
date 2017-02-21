class FileType{

  
  String filt(String x){    
    if(x.endsWith("svg")){
      path = x;
      
    }
    else if(x.endsWith("jpg")){    
      return path;
    }
    else{
      path = "THE ONLY ACCEPTABLE FILE TYPES: .svg, .jpg";      
    }
    return path;
  }

}