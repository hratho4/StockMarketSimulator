
<%@page import="java.io.InputStreamReader"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.io.BufferedReader"%>
<%@page import="java.net.URL"%>
<%@page import="com.uic.cs440.stockmarket.connection.connectionManager"%>
<%@page import="com.uic.cs440.stockmarket.beans.Player"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
       <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="css/bootstrap.min.css" rel="stylesheet" type="text/css"/>
        <title>Portfolio</title>
  		
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
    <script src="SpryAssets/SpryValidationTextField.js" type="text/javascript"></script>
    <link href="css/custom.css" rel="stylesheet" type="text/css"/>
    <link href="SpryAssets/SpryValidationTextField.css" rel="stylesheet" type="text/css">
    </head>

    <body style = "width: 1100px; height:100%">
       <!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
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
            
            $(document).ready(function() {
   $('td').each(function() {                                 
    var cellvalue = $(this).html();
   
    if ( cellvalue.substring(0,1) == '-' ) {
         $(this).wrapInner('<div style="color:red"></div>');   
    }
     if ( cellvalue.substring(0,1) == '+' )  {
         $(this).wrapInner('<div style="color:green"></div>');   
    }
   });                     
});
        </script>

        <script type="text/javascript" src="SymbolLookup_files/combo(8)"></script>
        <script type="text/javascript" src="SymbolLookup_files/combo(9)"></script>
        
    <!-- Include all compiled plugins (below), or include individual files as needed -->
    <script src="js/bootstrap.min.js"></script>
  
            
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
        
         <!-- Navigation bar starts -->
         <nav class="navbar navbar-default" style="color: white">
             <div class="container-fluid" id="nav_header">
    <!-- Brand and toggle get grouped for better mobile display -->
    <div class="navbar-header" >
    
      <a class="navbar-brand" href="/stockmarket5/homePortfolio.jsp" style="color:white">SE5 - Virtual Stock Trading Simulator</a>
    </div>

    <!-- Collect the nav links, forms, and other content for toggling -->
    <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
        <ul class="nav navbar-nav"  >
        <li class="active" ><a href="/stockmarket5/portfolio.jsp" style="color:white ;background: #1b9cc3">Portfolio <span class="sr-only">(current)</span></a></li>
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
            <li role="separator" class="divider"></li>
            <li><a href="/stockmarket5/LogoutServlet">Log Out</a></li>
          </ul>
        </li>
       
      </ul>
    </div><!-- /.navbar-collapse -->
  </div><!-- /.container-fluid -->
</nav>
         
         <!-- Navigation bar ends-->
          <div  class="row">
        <div class="col-md-12">
            <p style = "text-align: left;">Welcome <%=fname%>,
               
            </p>
        </div>
          </div>
            <div  class="row"></div>
    <div  class="row" ></div> <!-- End of Right -->
        <% 
        if(request.getParameter("s")!=null){
        if (request.getParameter("s").equals("success")) {
       %>
    
       <h4 style="color: green">  Message sent successfully!</h4>
        <%     
    } else if (request.getParameter("s").equals("fail")) {
   %>
   <h4 style="color: red"> Message failed. Try again!</h4>
    <% } }
        %> 
    <section id="main_body">
     
        
            <div style="border: 1px solid #e5a100;margin: 40px;padding: 30px;">
                <header> <h5>Contact Us:</h5></header>
 <% player = (Player) session.getAttribute("Player");%>
                <form name="contactus" method="post" action="contactUsServlet">
                  <table>
                        <tr>
                            <td><label>Name</label></td>
                            <td><span id="sprytextfield1">
                              <label for="name"></label>
                              <input type="text" name="name" id="name" value="<%=player.getFname()+" "+player.getLname()%>">
                            <span class="textfieldRequiredMsg">A value is required.</span></span></td>
                        </tr>
                        <tr>
                            <td><label>Subject</label></td>
                            <td><span id="sprytextfield2">
                              <label for="subject"></label>
                              <input type="text" name="subject" id="subject">
                            <span class="textfieldRequiredMsg">A value is required.</span></span></td>
                        </tr>
                        <tr>
                            <td><label>Email</label></td>
                            <td><span id="sprytextfield3">
                            <label for="email"></label>
                            <input type="text" name="email" id="email" value="<%=player.getEmail()%>">
                            <span class="textfieldRequiredMsg">A value is required.</span><span class="textfieldInvalidFormatMsg">Invalid format.</span></span></td>
                        </tr>
                        <tr>
                            <td><label>Message</label></td>
                            <td><textarea name="message" style="width: 200px; height: 100px"></textarea></td>
                        </tr>
                        <tr>
                            <td></td>
                            <td><input type="submit" name="submit" value="Submit"/></td>
                        </tr>
                    </table>
                </form>
            </div>
    </section>
    <script type="text/javascript">
var sprytextfield1 = new Spry.Widget.ValidationTextField("sprytextfield1");
var sprytextfield2 = new Spry.Widget.ValidationTextField("sprytextfield2");
var sprytextfield3 = new Spry.Widget.ValidationTextField("sprytextfield3", "email");
    </script>
    </body>
</html>
