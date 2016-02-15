<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="css/bootstrap.min.css" rel="stylesheet" type="text/css"/>
        <link href="css/custom.css" rel="stylesheet" type="text/css"/>

        <title>Stock Market Trading Simulator: Registration</title>
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

        <script type="text/javascript">
            function validateEmail()
            {
                var email = document.getElementById("email");
                var query = "SELECT COUNT(*) FROM player_balance WHERE email = \'" + email + "\'";
                try
                {
                    Connection conn = DriverManager.getConnection("jdbc:mysql://stockmarket5.mysql.uic.edu:3306/stockmarket5", "mmilin2", "ilove440");
                        Statement stmt = conn.createStatement();
                        ResultSet rs = stmt.executeQuery(query);
                        var exists = Number(rs);
                        if (exists > 0)
                        {
                            alert("The email address already registered with another account");
                            return false;
                        }
                        else
                        {
                            alert("The email address already registered with another account");
                            return true;
                        }

                }
                catch (ClassNotFoundException | SQLException e){
                    e.printStackTrace();
                }
            }
        </script>

    </head>
    <body class="" style = "width: 1100px;">

        <!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
        <script type="text/javascript" src="../../../js/countries.js"></script>
        <!-- Include all compiled plugins (below), or include individual files as needed -->
        <script src="js/bootstrap.min.js"></script>

        <div id="row" class="btn-info" style = "height: 50px; width: 100%;">
            <div class="panel-heading" style = "text-align: left;">
                <h3 class="panel-title">SE5 - Virtual Stock Trading Simulator</h3>
            </div>
        </div>

        <div class="row" style = "width: 100%;">
            <div class="col-md-2"></div>
            <div class="col-md-8">
                <div class="panel-heading" >
                    <h3 class="panel-title">New User Registration</h3>
                </div>
                <div class="panel-body">
                    <form id = "identicalForm" class="form-horizontal" name = "registrationForm" action="userRegistrationServlet" method="post"  onsubmit="return validateEmail();">
                        <div class="form-group">
                            <label for="inputfn" class="col-sm-2 control-label" >First Name</label>
                            <div class="col-sm-10">
                                <input type="text" pattern="[a-zA-Z ]+" title="Alphabets only" class="form-control" name="inputfn" placeholder="First Name" required>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="inputln" class="col-sm-2 control-label">Last Name</label>
                            <div class="col-sm-10">
                                <input type="text" pattern="[a-zA-Z ]+" title="Alphabets only" class="form-control" name="inputln" placeholder="Last Name" required>
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="bdate" class="col-sm-2 control-label">Date of birth </label>
                            <div class="col-sm-10">
                                <input type="date" class="form-control" name="bdate" >
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="country" class="col-sm-2 control-label">Country</label>
                            <div class="col-sm-4">
                                <input type="text" pattern="[a-zA-Z ]+" title="Alphabets only" class="form-control" name="country" placeholder="Country" required>
                            </div>
                            <label for="state" class="col-sm-2 control-label">State(Optional)</label>

                            <div class="col-sm-4">
                                <input type="text" pattern="[a-zA-Z ]+" title="Alphabets only" class="form-control" name="state" placeholder="State" >
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="city" class="col-sm-2 control-label">City </label>
                            <div class="col-sm-10">
                                <input type="text" class="form-control" name="city" placeholder="city" >
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="contactno" class="col-sm-2 control-label">Contact +1</label>
                            <div class="col-sm-10">
                                <input type="type" pattern="\d{10}$"  class="form-control" name="contactno" title="XXXXXXXXXX" placeholder="XXXXXXXXXX" required>
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="inputEmail" id = "email" class="col-sm-2 control-label">Email</label>
                            <div class="col-sm-10">
                                <input class="form-control" name="email" type="email" value="" placeholder="name@email.com"  data-fv-emailaddress-message="The value is not a valid email address" required>
                                <!--  <input type="email" class="form-control" name="inputEmail" placeholder="Email" required>-->
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="inputPassword" class="col-sm-2 control-label">Password</label>
                            <div class="col-sm-10">
                                <!-- <input type="password" class="form-control" name="inputPassword" placeholder="Password" required> -->
                                <input type="password" class="form-control" placeholder="password"  name="password" required/>	
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="confirmPassword" class="col-sm-2 control-label" >Retype Password</label>
                            <div class="col-sm-10">
                                <!-- <input type="password" class="form-control" name="confirmPassword" placeholder="Retype Password" required> -->
                                <input type="password" class ="form-control" name ="confirmPassword" data-fv-identical="true"
                                       data-fv-identical-field="password"
                                       data-fv-identical-message="The password and its confirm are not the same"
                                       required />
                            </div>
                        </div>


                        <div class="form-group">
                            <div class="col-sm-offset-2 col-sm-10">
                                <button type="submit" name="submit" class="btn btn-primary">Register</button>
                                <a href="/stockmarket5/login.jsp" class="btn btn-info">Back to Login</a>
                            </div>
                        </div>
                    </form> 



                </div>
            </div>
        </div>
        <div class="col-md-2"></div>

    </body>
</html>
