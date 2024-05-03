<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard</title>
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <link href="css/styles.css" rel="stylesheet"> <!-- Custom styles for this template -->
</head>
<body>
    <% 
    if (session.getAttribute("adminUsername") == null) {
        response.sendRedirect("adminLogin.jsp");
        return;
    }
    %>
    <header>
        <%@ include file="includes/adminNav.jsp" %> <!-- Navigation bar specific to admin -->
    </header>
    <div class="container-fluid">
        <div class="row">
            <main class="col-md-9 ms-sm-auto col-lg-10 px-md-4">
                <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
                    <h1 class="h2">Dashboard</h1>
                </div>
                <form name="menu">
                    <select name="sel" >
                    <option title="User" value="adminManageUsers.jsp">User's Table</option>
                    <option title="Reservation" value="adminManageReservations.jsp">Reservation Table</option>
                    <option title="Rooms" value="adminManageRooms.jsp">Rooms' Table</option>
                    </select>
                </form>
                <div class="btn-toolbar mb-2 mb-md-0">
                    <div class="btn-group me-2">
                        <button type="button" class="btn btn-sm btn-outline-secondary btn-export">Export Data</button>
                    </div>
                </div>
                <!-- Dashboard content goes here -->
                <h4>Welcome, <%= session.getAttribute("adminUsername") %></h4>
                <p>This is your admin dashboard where you can manage everything!</p>
            </main>
        </div>
    </div>
    <script type="text/javascript">
    document.addEventListener('DOMContentLoaded', function () {
        const exportButton = document.querySelector('.btn-export');
        exportButton.addEventListener('click', function () {
            tableToCSV();
        });
    });

    function tableToCSV() {
        // Variable to store the final csv data
        let csv_data = [];

        // Get the selected table URL
        const selectedTableURL = document.querySelector('select[name="sel"]').value;

        // Fetch the table dynamically using AJAX
        fetch(selectedTableURL)
            .then(response => response.text())
            .then(html => {
                const parser = new DOMParser();
                const doc = parser.parseFromString(html, 'text/html');

                // Get the table element
                const table = doc.querySelector('table');

                // Get each row data
                let rows = table.getElementsByTagName('tr');
                for (let i = 0; i < rows.length; i++) {
                    // Get each column data
                    let cols = rows[i].querySelectorAll('td,th');

                    // Stores each csv row data
                    let csvrow = [];
                    for (let j = 0; j < cols.length - 1; j++) {
                        // Get the text data of each cell
                        let cellValue = cols[j].innerHTML;

                        // Check if the cell value contains a comma
                        if (cellValue.includes(',')) {
                            // Surround the cell value with double quotes
                            cellValue = '"' + cellValue + '"';
                        }

                        // Push the cell value to csvrow
                        csvrow.push(cellValue);
                    }

                    // Combine each column value with comma
                    csv_data.push(csvrow.join(","));
                }

                // Combine each row data with new line character
                csv_data = csv_data.join('\n');

                // Call this function to download csv file  
                downloadCSVFile(csv_data);
            })
            .catch(error => {
                console.error('Error fetching table:', error);
            });
    }

    function downloadCSVFile(csv_data) {
        // Create CSV file object and feed csv_data into it
        CSVFile = new Blob([csv_data], {
            type: "text/csv"
        });

        // Create to temporary link to initiate download process
        let temp_link = document.createElement('a');

        // Download csv file
        temp_link.download = "table_data.csv";
        let url = window.URL.createObjectURL(CSVFile);
        temp_link.href = url;

        // This link should not be displayed
        temp_link.style.display = "none";
        document.body.appendChild(temp_link);

        // Automatically click the link to trigger download
        temp_link.click();
        document.body.removeChild(temp_link);
    }
</script>         
    <script src="js/bootstrap.bundle.min.js"></script>
</body>
</html>
