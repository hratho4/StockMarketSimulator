<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="css/bootstrap.min.css" rel="stylesheet" type="text/css"/>
        <title>Stock Market Trading Simulator</title>
   		
   		<style>
   			html
   			{
   				margin-left: 7%;
   				text-align: center;
   				height: 100%;
   				width: 1000px;
                                background-color: #FBFBFB
                                
   			}
   			#row
			{
				width: 100%;
				height: 50px;
				display: block;

				top: 0;
					
				font-size: 24px;
				text-align: left;
				vertical-align: text-top;
			}
			
			.row
			{
				width: 100%;
				margin-right: 0px;
                                margin-left:  0px;
				display: block;
				text-align: center;
				vertical-align: text-top;
				
			}
			
   		</style> 
    	
    	   
    </head>
    <body style = "width: 1100px;height: 100%;">
    <!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
    <!-- Include all compiled plugins (below), or include individual files as needed -->
    <script src="js/bootstrap.min.js"></script>
        
    <div id="row" class="btn-info"  style = "height: 50px; width: 100%;">
        	<div class="panel-heading" style = "text-align: left;">
                    <h3 class="panel-title" ><b>SE5 - Virtual Stock Trading Simulator</b></h3>
            	
            </div>
        </div>
    <div  style="background-color: #E5F2FF ; height: 100%">
        <div class="row" style = " width: 100%;">
            <div class="col-md-2"></div>
            <div class="col-md-8" style = "width: 600px;">
                <div class="panel-heading" style="margin-top: 50px; position:relative; width: 100px; left:50%">
                    	<h3 class="panel-title">Login</h3>
                    </div>
                    <div class="panel-body">
                        <form class="form-horizontal" action="\stockmarket5\userLoginServlet" method="post" >
                            <div class="form-group">
                                <label for="username" class="col-sm-2 control-label" >Username</label>
                                <div class="col-sm-10">
                                    <input type="email" class="form-control" name="username" placeholder="username@email.com" required>
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="inputln" class="col-sm-2 control-label">Password</label>
                                <div class="col-sm-10">
                                    <input type="password" class="form-control" name="password" placeholder="password" required>
                                </div>
                            </div>
       						<div class="form-group">
                                <div class="col-sm-offset-2 col-sm-10">
                                    <button type="submit" class="btn btn-primary">Sign In</button>
                                    <button type="button" onclick="location.href = '/stockmarket5/registration.jsp';" class="btn btn-info">Sign Up</button>
                            
                                </div>
                            </div>
                              <% if(session.getAttribute("message")!=null){%>
                                                    <div class="btn-danger col-lg-offset-2">    <%=session.getAttribute("message")%></div>
                                                    <%}
                                                    session.removeAttribute("message");%>    
                        </form>
                    </div>
                </div>
            </div>
            <div class="col-md-2"></div>
          
        </div>
                        
        
    </body>
</html>