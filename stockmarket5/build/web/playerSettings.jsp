<%@page import="com.uic.cs440.stockmarket.beans.Player" session="true"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="css/bootstrap.min.css" rel="stylesheet" type="text/css"/>
        <title>Stock Market Trading Simulator: Personal Setting</title>
    <style>
   			html
   			{
   				margin-left: 7%;
   				text-align: center;
   				height: 100%;
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
                  <link href="css/custom.css" rel="stylesheet" type="text/css"/>
      
    </head>
    <body class="" style = "width: 1100px;">
    <!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
    <!-- Include all compiled plugins (below), or include individual files as needed -->
    <script src="js/bootstrap.min.js"></script>
    <link rel="stylesheet" type="text/css" href="SymbolLookup_files/combo(1)"/>
       <script type="text/javascript">
            if(typeof YAHOO == "undefined"){YAHOO={};}
            if(typeof YAHOO.Finance == "undefined"){YAHOO.Finance={};}
            if(typeof YAHOO.Finance.SymbolSuggestConfig == "undefined"){YAHOO.Finance.SymbolSuggestConfig=[];}

            YAHOO.Finance.SymbolSuggestConfig.push({
                dsServer:'http://d.yimg.com/aq/autoc',
                dsRegion:'US',
                dsLang:'en-US',
                acInputId:'txtQuotes',
                acInputFormId:'quote',
                acContainerId:'quoteContainer',
                acInputFocus:'0'
            });
        </script>

        <script type="text/javascript" src="SymbolLookup_files/combo(8)"></script>
        <script type="text/javascript" src="SymbolLookup_files/combo(9)"></script>
    
    <%
                    java.sql.Connection con,con1;
                    java.sql.Statement s,s1;
                    java.sql.ResultSet rs,rs1;
                    String fname;
                    Float price=0f;
                    Boolean logged_in = Boolean.FALSE;
                    Player player = (Player) session.getAttribute("Player");
                    session.setAttribute("Usertmp", player);

                    if (player == null) {
                        fname="please login";
                      response.sendRedirect("/stockmarket5/login.jsp");
                    } else {
                        fname = player.getFname();
                        logged_in = Boolean.TRUE;
                    }
                    
                %>
        <nav class="navbar navbar-default" style="color: white">
             <div class="container-fluid" id="nav_header">
    <!-- Brand and toggle get grouped for better mobile display -->
    <div class="navbar-header" >
    
      <a class="navbar-brand" href="/stockmarket5/homePortfolio.jsp" style="color:white">SE5 - Virtual Stock Trading Simulator</a>
    </div>

    <!-- Collect the nav links, forms, and other content for toggling -->
    <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
        <ul class="nav navbar-nav"  >
        <li ><a href="/stockmarket5/portfolio.jsp" style="color:white">Portfolio <span class="sr-only">(current)</span></a></li>
        <li><a href="/stockmarket5/stockDetail.jsp" style="color:white ">Buy/Sell</a></li>
      </ul>
        <form class="navbar-form navbar-left" role="search" action="stockDetailServlet" method="get">
        <div class="form-group">
            <input id="txtQuotes" type="text" class="form-control" name="symbol" placeholder="Search stock" autocomplete="off" required >
	                           
        </div>
        <button type="submit" class="btn btn-default">Submit</button>
      </form>
      <ul class="nav navbar-nav navbar-right">
          <li class="dropdown">
             <a href="#"  style="color:white" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false" ><%=fname%> <span class="caret"></span></a>
          <ul class="dropdown-menu">
            <li><a href="/stockmarket5/playerSettings.jsp">Settings</a></li>
            <li><a href="/stockmarket5/contactus.jsp">Contact Us</a></li>
            <li role="separator" class="divider"></li>
            <li><a href="/stockmarket5/LogoutServlet">Log Out</a></li>
          </ul>
        </li>
       
      </ul>
    </div><!-- /.navbar-collapse -->
  </div><!-- /.container-fluid -->
</nav>
         
        <div class="row" style = "width: 100%;">
            <div class="col-md-2"></div>
            <div class="col-md-8">
                    <div class="panel-heading" >
                    	<h3 class="panel-title">Profile Setting</h3>
                   </div>
                    <div class="panel-body">
                        
                        <form id ="userSetting" class="form-horizontal" action="updatePlayerServlet" method="post" >
                            <div class="form-group">
                                <label for="inputfn" class="col-sm-2 control-label">Name</label>
                                <div class="col-sm-10">
                                    <label for="inputfn" class="col-sm-2 control-label" style="width : 120px"><%=player.getFname()%></label>
                                </div>
                            </div>       
                            <div class="form-group">
                                <label for="bdate" class="col-sm-2 control-label">Date of birth </label>
                                <div class="col-sm-10">
                                    <label for="inputfn" class="col-sm-2 control-label" style="width : 120px"><%=player.getBdate()%></label>
                                </div>
                            </div>
                            
                            <div class="form-group">
                                <label for="country" class="col-sm-2 control-label">Country</label>
                                <div class="col-sm-10">
                                    <label for="inputfn" class="col-sm-2 control-label" style="width : 120px"><%=player.getCountry()%></label>
                                    <p></p>
                                </div>
                               
                                <label for="state" class="col-sm-2 control-label">State</label>
                                <div class="col-sm-10">
                                    <label for="inputfn" class="col-sm-2 control-label" style="width : 120px"><%=player.getState()%></label>
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="city" class="col-sm-2 control-label">City </label>
                                <div class="col-sm-10">
                                    <label for="inputfn" class="col-sm-2 control-label" style="width : 120px"><%=player.getCity()%></label>
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="contactno" class="col-sm-2 control-label">Contact Number</label>
                                <div class="col-sm-10">
                                    <input type="text" class="form-control" name="contactno" placeholder="<%=player.getContactno()%>" required>
                                </div>
                            </div>
                                                        
                            <div class="form-group">
                                <label for="inputEmail" class="col-sm-2 control-label">Email</label>
                                <div class="col-sm-10">
                                    <input class="form-control" name="email" type="email" placeholder=<%=player.getEmail()%>  data-fv-emailaddress-message="The value is not a valid email address" />
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="inputPassword" class="col-sm-2 control-label">Old Password</label>
                                <div class="col-sm-10">
                                    <input type="password" class="form-control" name="oldPassword" placeholder="Password" required>
                                </div>
                            </div>                            
                            <div class="form-group">
                                <label for="inputPassword" class="col-sm-2 control-label">New Password</label>
                                <div class="col-sm-10">
                                	 <input type="password" class="form-control" name="newPassword" placeholder = "password"/>
                                    <!--<input type="password" class="form-control" name="inputPassword" placeholder="Password" required> -->
                                </div>
                            </div>
                            
<!--                            <div class="form-group">
                                <label for="confirmPassword" class="col-sm-2 control-label">Retype New Password</label>
                                <div class="col-sm-10">
                                     <input type="password" class="form-control" name="confirmPassword" placeholder="Retype Password" required> 
                                     <input type="password" class="form-control" name="confirmPassword"
								                data-fv-identical="true"
								                data-fv-identical-field="password"
								                data-fv-identical-message="The password and its confirm are not the same"  placeholder="Retype Password"/>
                                </div>
                            </div> -->
                            <div class="form-group">
                                <div class="col-sm-offset-2 col-sm-10">
                                    <button type="submit" class="btn btn-primary">Update</button>
                                      <a href="/stockmarket5/homePortfolio.jsp" class="btn btn-primary">Cancel</a>
                                </div>
                            </div>
                            
                        </form>
                        <script>
                            $(document).ready(function() {
			    $('#userSetting').formValidation();
			});
			</script>
                    </div>
                </div>
            </div>
    
        
    </body>
</html>
