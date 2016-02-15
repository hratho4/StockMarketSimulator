<%@page import="java.text.DecimalFormat"%>
<%@page import="com.uic.cs440.stockmarket.beans.PlayerBalance"%>
<%@page import="javax.swing.JOptionPane"%>
<%@page import="com.uic.cs440.stockmarket.connection.connectionManager"%>
<%@page import="com.uic.cs440.stockmarket.beans.Player"%>
<%@page import="java.util.StringTokenizer"%>
<%@page import="java.io.BufferedReader"%>
<%@page import="java.io.InputStreamReader"%>
<%@page import="java.net.URLConnection"%>
<%@page import="java.net.URL"%>
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
        <!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
        <!-- Include all compiled plugins (below), or include individual files as needed -->

        <link rel="stylesheet" type="text/css" href="SymbolLookup_files/combo(1)"/>
        <script type="text/javascript">
            if (typeof YAHOO == "undefined") {
                YAHOO = {};
            }
            if (typeof YAHOO.Finance == "undefined") {
                YAHOO.Finance = {};
            }
            if (typeof YAHOO.Finance.SymbolSuggestConfig == "undefined") {
                YAHOO.Finance.SymbolSuggestConfig = [];
            }

            YAHOO.Finance.SymbolSuggestConfig.push({
                dsServer: 'http://d.yimg.com/aq/autoc',
                dsRegion: 'US',
                dsLang: 'en-US',
                acInputId: 'txtQuotes',
                acInputFormId: 'quote',
                acContainerId: 'quoteContainer',
                acInputFocus: '0'
            });
        </script>
        <script type="text/javascript" src="SymbolLookup_files/combo(8)"></script>
        <script type="text/javascript" src="SymbolLookup_files/combo(9)"></script>

        <script type="text/javascript">
            function validateSell()
            {
                if (document.sell_stock.sell_quantity.value > document.sell_stock.qty.value)
                {
                    alert("Sell quantity is more that what your holdings");
                    document.sell_stock.sell_quantity.focus();
                    return false;
                }
                if (document.sell_stock.sell_quantity.value < 1)
                {
                    alert("Sell quantity should be greater than 0");
                    document.sell_stock.sell_quantity.focus();
                    return false;
                }
            }
        </script>
        <script type="text/javascript">
            function validateBuy()
            {
                if (document.buy_stock.buy_quantity.value * document.buy_stock.price.value > document.buy_stock.balance.value)
                {
                    alert("Dont have sufficient balance");
                    document.buy_stock.buy_quantity.focus();
                    return false;
                }
                if (document.buy_stock.buy_quantity.value < 1)
                {
                    alert("Buy quantity should be greater than 0");
                    document.sell_stock.sell_quantity.focus();
                    return false;
                }
            }
        </script>
    </head>

    <body class="" style = "width: 1100px;">
        <!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
        <script src="js/bootstrap.min.js"></script>
        <%
            java.sql.Connection con, con1;
            java.sql.Statement s, s1;
            java.sql.ResultSet rs, rs1;
            String fname;
            Float price = 0f;
            Boolean logged_in = Boolean.FALSE;
            Player player = (Player) session.getAttribute("Player");
            session.setAttribute("Usertmp", player);

            if (player == null) {
                fname = "Guest";
            } else {
                fname = player.getFname();
                logged_in = Boolean.TRUE;
            }
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
                        <li><a href="/stockmarket5/stockDetail.jsp" style="color:white;background: #1b9cc3 ">Buy/Sell</a></li>
                    </ul>

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
        <div  class="row">
            <div class="col-md-12">
                <p style = "text-align: left;"><% if (logged_in) {
                        PlayerBalance pb = (PlayerBalance) session.getAttribute("PlayerBalance");
                        DecimalFormat df = new DecimalFormat();
                        df.setMaximumFractionDigits(2);
                    %>
                    Available Balance: $<%=df.format(pb.getBalance())%>
                    <% } %>

                </p>
            </div>   
            <br>

            <div class="row" style = "height: 350px; width: 100%;">
                <div class="col-md-12"></div>
                <div class = "col-md-8" style = "height: 100%;">    
                    <div class = "panel panel-default">
                        <div class="panel-heading" >
                            <h3 class="panel-title">Stock Detail</h3>
                        </div>

                        <div class="panel-body" style = "width: 100%;">  
                            <div class="col-md-12">
                                <div class = "col-md-12"></div>
                                <p id = "stockDetailPrintId">
                                    <%

                                        if (request.getParameterMap().containsKey("symbol")) {
                                            String n = request.getParameter("symbol").toString();
                                            try {
                                                URL url = new URL("http://quote.yahoo.com/d/quotes.csv?s=" + n + "&f=sl1d1t1c1ohgv&e=.csv");
                                                URLConnection urlConn = url.openConnection();
                                                InputStreamReader inStream = new InputStreamReader(urlConn.getInputStream());
                                                BufferedReader buff = new BufferedReader(inStream);
                                                String csvString = buff.readLine();
                                                StringTokenizer tokenizer = new StringTokenizer(csvString, ",");
                                                String stcknm = tokenizer.nextToken();
                                                price = Float.parseFloat(tokenizer.nextToken());

                                    %>
                                <div class="col-sm-4">Company</div><div class="col-sm-4"><%=stcknm%></div> </br>
                                <div class="col-sm-4">Last Price</div><div class="col-sm-4"><%=price%></div> </br>
                                <div class="col-sm-4">Date</div><div class="col-sm-4"><%=tokenizer.nextToken().substring(1, 10) + " " + tokenizer.nextToken().substring(1, 7)%></div></br>
                                <div class="col-sm-4">Change</div><div class="col-sm-4"><%=tokenizer.nextToken()%></div> </br>
                                <div class="col-sm-4">Open</div><div class="col-sm-4"><%=tokenizer.nextToken()%></div> </br>
                                <div class="col-sm-4">High</div><div class="col-sm-4"><%=tokenizer.nextToken()%></div> </br>
                                <div class="col-sm-4">Low</div><div class="col-sm-4"><%=tokenizer.nextToken()%></div> </br>


                                <%
                                if (logged_in) {%>

                                <form name="buy_stock" method="post" action="buyStockServlet">
                                    <input type="number" name="buy_quantity">
                                    <input type="text" name="price" value=<%=price%> hidden>
                                    <input type="text" name="stck" value=<%=stcknm%> hidden>
                                    <%  PlayerBalance pb = (PlayerBalance) session.getAttribute("PlayerBalance");%>
                                    <input type="text" name="balance" value=<%=pb.getBalance()%> hidden>

                                    <input type="submit" value="buy" onclick="return validateBuy();">
                                </form>

                                <%
                                        }
                                    } catch (Exception ee) {
                                    }

                                } else {
                                %>            
                                Search Stock on Right to Get Started!
                                <% } %>


                            </div>
                        </div>
                    </div>
                </div>

                <div class = "col-md-4" style = "height: 80%;">
                    <div class = "panel panel-default">
                        <div class="panel-heading" >
                            <h3 class="panel-title">Search Stock</h3>
                        </div>

                        <div class="panel-body">
                            <form class="form-horizontal" action="" method="get" >
                                <div class="col-md-11">
                                    <div class="form-group">
                                        <div class="col-md-12">
                                            <input id="txtQuotes" type="text" class="form-control" name="symbol" placeholder="e.g aapl, tsla, bby" autocomplete="off" required>
                                        </div>
                                    </div>

                                    <div class="form-group">
                                        <div class="col-sm-offset-2 col-sm-10">
                                            <button type="submit" class="btn btn-primary">Search Stock</button>
                                        </div>
                                    </div>
                                </div>

                            </form>
                        </div>


                    </div>    
                </div>
            </div>
            <% if (logged_in) {
                if (request.getParameterMap().containsKey("symbol")) {%> 
            <div id = "buySellBlockId" >
                <div class="row" >
                    <div class="col-md-12"></div>
                    <div class = "col-md-12" style = "height: 100%;">    
                        <div class = "panel panel-default">
                            <div class="panel-heading" >
                                <h3 class="panel-title">Sell Trade</h3>
                            </div>

                            <div class="col-md-3">Company</div><div class="col-md-3">Quantity</div>
                            <div class="col-md-3">Sell Quantity</div> <div class="col-md-3">Action</div>

                            <%
                                try {
                                    con = null;
                                    s = null;
                                    rs = null;
                                    con = connectionManager.getConnection();
                                    s = con.createStatement();
                                    String q = "select * from stock_info where email='" + player.getEmail() + "' AND stock_sym='" + request.getParameter("symbol").toString() + "'";
                                    rs = s.executeQuery(q);
                                    boolean valid = rs.next();
                                    System.out.println(q);
                                    System.out.println(valid + " stock info" + player.getEmail() + " ---" + request.getParameter("symbol").toString());
                                    if (valid) {
                                        rs.beforeFirst();
                                        while (rs.next()) {
                                            String stcknm = rs.getString("stock_sym");
                                            String quantity = rs.getString("quantity");
                            %>
                            <div class="col-md-3"><%=stcknm%></div><div class="col-md-3"><%=quantity%></div>
                            <div class="col-md-6">
                                <div class="form-group col-md-6">
                                    <form name="sell_stock" action="SellStockServlet" method="post">
                                        <input type="number" name="sell_quantity">
                                        <input type="text" name="qty" value=<%=quantity%> hidden>
                                        <input type="text" name="stck" value=<%=stcknm%> hidden>
                                        <input type="text" name="price" value=<%=price%> hidden>                    
                                        </div>

                                        <div class="form-group">

                                            <input type="submit" value="sell" onclick="return validateSell();">
                                        </div>


                                </div>

                                <%
                                            }
                                        }
                                    } catch (Exception e) {
                                        System.out.println("Error : " + e);
                                    }
                                %>

                                <div class="panel-body">  
                                    <div class="col-md-12" style = "border-bottom: thin solid black;">
                                        <p style = "text-align: center;">Transactions History for <%=request.getParameter("symbol").toString()%></p>
                                        <%
                                            try {
                                                con1 = null;
                                                s1 = null;
                                                rs1 = null;
                                                con1 = connectionManager.getConnection();
                                                s1 = con1.createStatement();
                                                String q = "select * from stock_transactions where email='" + player.getEmail() + "' and stock_sym = \'" + request.getParameter("symbol").toString() + "\'";
                                                rs1 = s1.executeQuery(q);

                                                boolean valid = rs1.next();
                                                if (valid) {
                                        %>
                                        <br/>
                                        <form name="frm" method="post" style="padding-left: 40px">

                                            <table border="1">

                                                <div class="col-md-3">Transaction ID</div>
                                                <div class="col-md-3">Date</div>
                                                <div class="col-md-2">Price</div>
                                                <div class="col-md-2">Quantity</div>
                                                <div class="col-md-2">Buy/Sell</div>

                                                <%
                                                    rs1.beforeFirst();
                                                    while (rs1.next()) {
                                                        String stcknm = rs1.getString("transaction_id");
                                                        String date = rs1.getString("tdate");
                                                        String price1 = rs1.getString("price");
                                                        String quantity = rs1.getString("quantity");
                                                        String type = rs1.getString("type");
                                                        int ty = Integer.parseInt(type);

                                                        if (ty == 0) {
                                                            type = "Buy";
                                                        } else {
                                                            type = "Sell";
                                                        }
                                                %>

                                                <tr>
                                                <div><label class="col-md-3"><%= stcknm%></div>
                                                <div><label class="col-md-3"><%= date%></label></div>
                                                <div><label class="col-md-2"><%= price1%></label></div>
                                                <div><label class="col-md-2"><%= quantity%></label></td>
                                                    <div><label class="col-md-2""><%= type%></label></td>
                                                        </tr>

                                                        <%
                                                                    }

                                                                } else {
                                                                    JOptionPane.showMessageDialog(null, "Transactions Not Found !!");
                                                                }
                                                            } catch (Exception e) {
                                                                System.out.println("Error : " + e);
                                                            }

                                                        %>



                                                    </div>   	           
                                                </div>
                                                </div>
                                                </div>
                                                </div>
                                                </div>
                                                <% }
            }%>

                                                </body>


                                                </html>
