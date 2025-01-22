document.addEventListener("DOMContentLoaded", function() {
    var table = document.getElementById("thong-tin-table");
    var cells = table.getElementsByTagName("th");

    for (var i = 0; i < cells.length; i++) {
        cells[i].addEventListener("mouseover", function() {
            this.classList.add("highlight");
        });

        cells[i].addEventListener("mouseout", function() {
            this.classList.remove("highlight");
        });
    }
});


function Xacnhandienthongtin() {
    // Gather form data
    const form = document.getElementById('infoForm');
    const name = form.name.value;
    const gender = form.gender.value;
    const className = form.class.value;
    // const department = form.department.value;
    const email = form.email.value;
    const address = form.address.value;
    const status = form.status.value;

    // Check if any field is empty
    const requiredFields = [name, gender, className, email, address, status];
    const emptyFieldIndex = requiredFields.findIndex(field => field.trim() === '');
    if (emptyFieldIndex !== -1) {
        alert("Vui lòng điền đầy đủ thông tin.");
        return; // Stop execution if any field is empty
    }

    // Create a new row
    const table = document.getElementById('tableBody');
    const newRow = table.insertRow();

    newRow.innerHTML = `
        <td>${name}</td>
        <td>${gender}</td>
        <td>${className}</td>
        
        <td>${email}</td>
        <td>${address}</td>
        <td>${status}</td>
        <td>
            <button class="nut-sua" onclick="editRow(this)">Sửa</button>
            <button class="nut-xoa" onclick="deleteRow(this)">Xóa</button>
        </td>
    `;

    // Clear form fields
    form.reset();
}

document.getElementById('Xac-nhan-dien-thong-tin').addEventListener('click', function(event) {
    event.preventDefault();
    Xacnhandienthongtin();
});


function deleteRow(button) {
    const row = button.parentElement.parentElement;
    row.remove();
}

function editRow(button) {
    const row = button.parentElement.parentElement;
    const cells = row.getElementsByTagName('td');

    // Populate form with row data
    document.getElementById('name').value = cells[0].textContent;
    document.querySelector(`input[name="gender"][value="${cells[1].textContent}"]`).checked = true;
    document.getElementById('class').value = cells[2].textContent;
    // document.getElementById('department').value = cells[3].textContent;
    document.getElementById('email').value = cells[3].textContent;
    document.getElementById('address').value = cells[4].textContent;
    document.getElementById('status').value = cells[5].textContent;

    // Remove the row being edited
    row.remove();
}




