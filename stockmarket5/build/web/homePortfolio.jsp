<%@page import="com.uic.cs440.stockmarket.beans.Player"%>
<%@page import="com.uic.cs440.stockmarket.beans.PlayerBalance"%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="css/bootstrap.min.css" rel="stylesheet" type="text/css"/>
        <link href="css/custom.css" rel="stylesheet" type="text/css"/>
       
        <title>Stock Market Trading Simulator Portfolio Home</title>
   		
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
    <script src="Chart.js"></script> 
    
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
                                                String fname;
                                                Player player= (Player) session.getAttribute("Player");
                                                session.setAttribute("Usertmp", player);
            if (player == null) {
                response.sendRedirect("/stockmarket5/login.jsp");
            } else {
                fname = player.getFname();
                System.out.println("Client id is : " + fname);
            
                                        %>
                                            
        <nav class="navbar navbar-default" style="color: white">
             <div class="container-fluid" id="nav_header">
    <!-- Brand and toggle get grouped for better mobile display -->
    <div class="navbar-header" >
    
      <a class="navbar-brand active" href="/stockmarket5/homePortfolio.jsp" style="color:white ">SE5 - Virtual Stock Trading Simulator</a>
    </div>

    <!-- Collect the nav links, forms, and other content for toggling -->
    <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
        <ul class="nav navbar-nav"  >
        <li ><a href="/stockmarket5/portfolio.jsp" style="color:white">Portfolio </a></li>
        <li><a href="/stockmarket5/stockDetail.jsp" style="color:white ">Buy/Sell</a></li>
      </ul>
        <form class="navbar-form navbar-left" role="search" action="stockDetailServlet" method="get">
        <div class="form-group">
            <input id="txtQuotes" type="text" class="form-control" name="symbol" placeholder="Search stock" autocomplete="off" required >
	                           
        </div>
        <button type="submit" class="btn btn-default">Search</button>
      </form>
      <ul class="nav navbar-nav navbar-right">
          <li class="dropdown">
             <a href="#"  style="color:white" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false" >  <%=player.getFname()%><span class="caret"></span></a>
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
         
        
        
        <div class="row" style = "height: 350px; width: 100%;">
            <div class="col-md-12"></div>
	        <div class = "col-md-8" style = "height: 100%;">    
	             <div class = "panel panel-default">
		             <div class="panel-heading" >
		             	<h3 class="panel-title">Portfolio</h3>
		             </div>
		             
		             <div class="panel-body" style = "width: 100%;">  
		             	<div class="col-md-12" style = "border-bottom: thin solid black;">
		             		<p style = "text-align: left;">Welcome 
                                            <a href="/stockmarket5/playerSettings.jsp">
                                            <%=player.getFname()%></a>
                                            </p>
		             	</div>   
		                <div class="col-md-8">
		                     <p><b>Portfolio Summary</b></p>
                                     <a href="./portfolio.jsp">Portfolio</a>
		                     <div>
								<canvas id="canvasTop" style = "width: 100%; height:200px;"></canvas>
							</div>	
		
							<script>			
							var barData = {
								    labels: ['0-10', '10-20', '20-50', '50-100', '100-200', '200-400', '400+'],
								    datasets: [
								        {
								            label: 'Quick Statistics Table',
								            fillColor: 'grey',
								            data: [1,2,3,4,5,6,7]
								        }
								        
								    ]
								};
							</script>
		                </div>
		                 
		                <div class="col-md-4">
		                    <p><b>Quick Analysis</b></p>
                                    <% PlayerBalance pb = (PlayerBalance) session.getAttribute("PlayerBalance");%>
                                    <% if (pb!=null){ %>
		                    <p style = "text-align: left;"><b>Cash Balance: </b><%=pb.getBalance()%></p>
		                    <p style = "text-align: left;"><b>Profit/Loss: </b> N/A</p>
		                    <p style = "text-align: left;"><b># of Holdings: </b>N/A</p>
		                    <p style = "text-align: left;"><b>Major Sector: </b>N/A</p>
		                    <p style = "text-align: left;"><b>Member Since: </b>Jan 2015</p>
		                    <p style = "text-align: left;"><b>City: </b> <%=player.getCity()%><% } else { %></p>
                                     <p style = "text-align: left;"><b>Cash Balance: </b>10000</p>
		                    <p style = "text-align: left;"><b>Profit/Loss: </b> N/A</p>
		                    <p style = "text-align: left;"><b># of Holdings: </b>N/A</p>
		                    <p style = "text-align: left;"><b>Major Sector: </b>N/A</p>
		                    <p style = "text-align: left;"><b>Member Since: </b>Jan 2015</p>
                                    <% } }%>
		                    <p style = "text-align: left;"><b>Rank: </b>N/A</p>
		                </div>
		             </div>
	             </div>
	        </div>
	        
	        <div class = "col-md-4" style = "height: 100%;">
                            <div class = "panel panel-default">
		             <div class="panel-heading" >
		             	<h3 class="panel-title">Glance at Market</h3>
		             </div>
                            <script src="http://widgets.macroaxis.com/widgets/url.jsp?t=15&s=^IXIC,^GSPC,^DJI"></script>
                            </div>
	         </div>
	              
	     </div>
                                    <br>     
	<div class="row" style = "height: 250px;">
            <div class="col-md-12"></div>
	        <div class = "col-md-12" style = "height: 100%;">    
	             <div class = "panel panel-default">
		             <div class="panel-heading" >
		             	<h3 class="panel-title">Glance at Market</h3>
		             </div>
		             
		             <div class="panel-body">  
		             	<div class="col-md-12" style = "border-bottom: thin solid black;">
		             		<p style = "text-align: center;">Market Summary</p>
		             	</div>   
		                <div class="col-md-12">
		                     <p><b>Portfolio Summary</b></p>
		                     	
						</div>
    				</div>
    			</div>
    		</div>
    	</div>
    </body>
    
    
    <script>
    	$(document).ready(function() {
    		var context = document.getElementById('canvasTop').getContext('2d');
    		var clientsChart = new Chart(context).Bar(barData);
    	})
    </script>
</html>
