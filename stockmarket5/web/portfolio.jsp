

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

        <link href="css/custom.css" rel="stylesheet" type="text/css"/>

    </head>

    <body style = "width: 1100px; height:100%">
        <!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
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

            $(document).ready(function () {
                $('td').each(function () {
                    var cellvalue = $(this).html();

                    if (cellvalue.substring(0, 1) == '-') {
                        $(this).wrapInner('<div style="color:red"></div>');
                    }
                    if (cellvalue.substring(0, 1) == '+') {
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
            java.sql.Connection con, con1;
            java.sql.Statement s, s1;
            java.sql.ResultSet rs, rs1;
            String fname;
            Float price = 0f;
            Boolean logged_in = Boolean.FALSE;
            Player player = (Player) session.getAttribute("Player");
            session.setAttribute("Usertmp", player);

            if (player == null) {
                fname = "please login";
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
                                <li><a href="/stockmarket5/contactus.jsp">Contact Us</a></li>
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
        <div  class="row"style = "height: 200px " >
            <div class="col-lg-12">
                <% String cuid;
                    java.sql.Connection con2;
                    java.sql.Statement s2;
                    java.sql.ResultSet rs2;
                    //   Player player = (Player)session.getAttribute("Player");
                    session.setAttribute("Usertmp", player);
                    if (player == null) {
                        response.sendRedirect("/stockmarket5/login.jsp");
                    } else {
                        cuid = player.getEmail();
                        System.out.println("Client id is : " + cuid);
                %>
                <%
                    System.out.println("Client id is : " + cuid);

                    con = null;
                    s = null;
                    boolean valid;
                    rs = null;

                    try {
                        con = connectionManager.getConnection();
                        s = con.createStatement();
                        String q = "select * from stock_info where email='" + cuid + "'";
                        rs = s.executeQuery(q);

                        valid = rs.next();

                        if (valid) {
                            rs.beforeFirst();

                            String allsym1 = "";
                            int i = 0;
                            while (rs.next()) {
                                allsym1 = allsym1 + rs.getString("stock_sym") + "+";
                            }
                            String allsym = "";
                            System.out.println(allsym1);
                            try {
                                allsym = allsym1.substring(0, allsym1.length() - 1);
                            } catch (Exception ex) {
                                System.out.print("this:" + ex);
                            }

                            URL u1 = new URL("http://finance.yahoo.com/d/quotes.csv?s=" + allsym + "&f=sl1d1t1c1ohgv&e=.csv");
                            BufferedReader bf1 = new BufferedReader(new InputStreamReader(u1.openStream()));
                            rs.beforeFirst();
                            float total_inv = 0, latest_value1 = 0;
                            float d_g1 = 0, o_g1 = 0;
                            String t_i = null;
                            String d_g2 = null, o_g2 = null, latest_value2 = null;
                            DecimalFormat df = new DecimalFormat();

                            df.setMaximumFractionDigits(2);
                            while (rs.next()) {

                                int q2 = Integer.parseInt(rs.getString("quantity"));
                                float i_p = Float.parseFloat(rs.getString("price"));
                                total_inv = total_inv + (q2 * i_p);

                                t_i = String.valueOf(total_inv);

                                String dataRow1 = bf1.readLine();
                                String[] dataArray1 = dataRow1.split(",");
                                String string1 = dataArray1[4].replace("\"", "");
                                System.out.println(string1);
                                for (int o = 0; o < dataArray1.length; o++) {
                                    System.out.println(o + " " + dataArray1[o]);
                                }

                                float ch1 = Float.parseFloat(string1);  ///change
                                float l_p1 = Float.parseFloat(dataArray1[1]);   ///live price

                                d_g1 = d_g1 + q2 * ch1;

                                d_g2 = df.format(d_g1);

                                o_g1 = o_g1 + ((q2 * l_p1) - (q2 * i_p));
                                if (o_g1 < 0) {
                                    o_g2 = "-" + df.format(o_g1);
                                } else {
                                    o_g2 = "+" + df.format(o_g1);
                                }
                                latest_value1 = latest_value1 + (q2 * l_p1);
                                latest_value2 = df.format(latest_value1);
                            }
                %>
                <div class="row" style = "height: 350px; width: 100%;">
                    <div class="col-md-12"></div>
                    <div class = "col-md-8" style = "height: 100%;">    
                        <div class = "panel panel-default">
                            <div class="panel-heading" >
                                <h3 class="panel-title">Overall Investment Detail</h3>
                            </div>

                            <div class="panel-body" style = "width: 100%;">  
                                <div class="col-md-12">
                                    <div class = "col-md-12"></div>
                                    <p id = "stockDetailPrintId">
                                    <div class="col-sm-4">Investment</div><div class="col-sm-4"><%= t_i%></div> </br>
                                    <div class="col-sm-4">Today's Gain</div><div class="col-sm-4"><%= d_g2%></div> </br>
                                    <div class="col-sm-4">Overall Gain</div><div class="col-sm-4"><%= o_g2%></div></br>
                                    <div class="col-sm-4">Latest</div><div class="col-sm-4"><%= latest_value2%></div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!--Platers Stock Details -->
        <div id = "myStocks" sytle = "height: 300px "> 
            <table class="table">
                
                <thead>
                    <tr>
                        <th>Company</th>
                        <th>Name</th>
                        <th>Live Price</th>
                        <th>Change</th>
                        <th>Quantity</th>
                        <th>Investment Price</th>
                        <th>Day's Gain</th>
                        <th>Day's Gain(%)</th>
                        <th>Overall Gain</th>
                        <th>Overall Gain(%)</th>
                        <th>Latest Value</th>
                    </tr>
                </thead>
                <tbody sytle = "    height: 100px;
                                    overflow-y: auto;
                                    overflow-x: hidden; ">
                                            <%
                            rs.beforeFirst();
                            URL u = new URL("http://finance.yahoo.com/d/quotes.csv?s=" + allsym + "&f=sl1d1t1c1nohgv&e=.csv");
                            BufferedReader bf = new BufferedReader(new InputStreamReader(u.openStream()));
                            while (rs.next()) {%>
                    <tr style="color:green; font:bold">
                        <td><div style="color:black"><%= rs.getString("stock_sym")%></div></td>
                            <%
                                String dataRow = bf.readLine();
                                String[] dataArray = dataRow.split(",");
                                float l_p = Float.parseFloat(dataArray[1]);
                                String string = dataArray[4].replace("\"", "");
                                float ch = Float.parseFloat(string);
                                float latest_value = 0;
                                String l_v = null;

                                int q1 = Integer.parseInt(rs.getString("quantity"));
                                float i_p = Float.parseFloat(rs.getString("price"));
                                float o_g, o_gp, d_g, d_gp, yst_price;
                                float x = q1 * i_p;
                                latest_value = q1 * l_p;
                                l_v = String.valueOf(latest_value);
                                d_g = q1 * ch;
                                if (ch > 0) {
                                    yst_price = l_p - ch;
                                } else {
                                    yst_price = l_p + ch;
                                }
                                d_gp = (ch * 100) / yst_price;
                                o_g = (q1 * l_p) - (x);
                                if ( x != 0)
                                {
                                     o_gp = (100 * o_g) / x;
                                }
                                else
                                {
                                    o_gp = 0;
                                }
                                System.out.println("latest value:" + l_v + " day gain:" + d_g
                                        + "overal=" + q1 + "*" + l_p + "-" + x + "=" + o_g);

                                String ov_gain = df.format(o_g);
                                String ov_gainp = df.format(o_gp);
                                String day_gain = df.format(d_g);
                                String day_gainp = df.format(d_gp);
                            %>

                        <td><div style="color:black"><%=dataArray[5].substring(1, dataArray[5].length() - 1)%></div></td>
                        <td><%=dataArray[1]%></td>
                        <td><%=dataArray[4]%></td>
                        <td><%= rs.getString("quantity")%></td>
                        <td><%= rs.getString("price")%></td>
                        <td ><%= day_gain%></td>
                        <td><%= day_gainp%></td>
                        <td><%=ov_gain%></td>
                        <td><%=ov_gainp%></td>
                        <td><%=l_v%></td>
                    </tr>
                    <%
                                    }
                                }
                            } catch (Exception e) {
                                System.out.print(e);
                            }
                        }
                    %>

                </tbody>
            </table>

        
        </div>                        

                                        <!-- End of Right -->


    </body>
</html>
