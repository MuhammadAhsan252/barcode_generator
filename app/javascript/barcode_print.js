// Barcode Print Functionality

function printBarcode() {
  const quantity = document.getElementById('printQuantity').value;
  const barcodeModal = document.getElementById('printModal');
  
  // Validate quantity
  if (!quantity || quantity < 1 || quantity > 100) {
    alert('Please enter a valid quantity between 1 and 100');
    return;
  }

  // Get barcode details
  const barcodeName = barcodeModal.querySelector('.modal-body h4').textContent;
  const barcodeImage = barcodeModal.querySelector('.modal-body img');
  const barcodeValue = barcodeModal.querySelector('code').textContent;

  if (!barcodeImage) {
    alert('No barcode image available for printing');
    return;
  }

  // Create print content
  const printContent = createPrintContent(barcodeName, barcodeImage.src, barcodeValue, quantity);
  
  // Open print window
  const printWindow = window.open('', '_blank');
  printWindow.document.write(printContent);
  printWindow.document.close();
  
  // Wait for content to load then print
  printWindow.onload = function() {
    printWindow.focus();
    printWindow.print();
    
    // Close modal after printing
    const modal = bootstrap.Modal.getInstance(barcodeModal);
    modal.hide();
  };
}

function createPrintContent(name, imageSrc, value, quantity) {
  let barcodeItems = '';
  
  // Generate barcode items based on quantity
  for (let i = 0; i < quantity; i++) {
    barcodeItems += `
      <div class="barcode-item">
        <h3>${name}</h3>
        <img src="${imageSrc}" alt="Barcode for ${name}" />
        <p class="barcode-value">${value}</p>
      </div>
    `;
  }

  return `
    <!DOCTYPE html>
    <html>
    <head>
      <title>Print Barcodes - ${name}</title>
      <style>
        body {
          font-family: Arial, sans-serif;
          margin: 20px;
          background: white;
        }
        
        .print-header {
          text-align: center;
          margin-bottom: 30px;
          border-bottom: 2px solid #333;
          padding-bottom: 20px;
        }
        
        .print-header h1 {
          margin: 0;
          color: #333;
        }
        
        .print-header p {
          margin: 5px 0 0 0;
          color: #666;
          font-size: 14px;
        }
        
        .barcodes-container {
          display: flex;
          flex-wrap: wrap;
          gap: 20px;
          justify-content: center;
        }
        
        .barcode-item {
          border: 1px solid #ddd;
          padding: 20px;
          text-align: center;
          background: white;
          border-radius: 8px;
          min-width: 300px;
          max-width: 400px;
          page-break-inside: avoid;
        }
        
        .barcode-item h3 {
          margin: 0 0 15px 0;
          color: #333;
          font-size: 18px;
          font-weight: bold;
        }
        
        .barcode-item img {
          max-width: 100%;
          height: auto;
          margin: 15px 0;
          border: 1px solid #eee;
          padding: 10px;
          background: white;
        }
        
        .barcode-value {
          font-family: 'Courier New', monospace;
          background: #f8f9fa;
          padding: 8px 12px;
          border-radius: 4px;
          margin: 15px 0 0 0;
          font-size: 14px;
          color: #333;
          border: 1px solid #dee2e6;
        }
        
        @media print {
          body {
            margin: 0;
          }
          
          .print-header {
            margin-bottom: 20px;
          }
          
          .barcode-item {
            border: 2px solid #333;
            margin-bottom: 20px;
          }
          
          .barcodes-container {
            gap: 15px;
          }
        }
        
        @page {
          margin: 1in;
        }
      </style>
    </head>
    <body>
      <div class="print-header">
        <h1>Barcode Print Sheet</h1>
        <p>Generated on ${new Date().toLocaleDateString()} at ${new Date().toLocaleTimeString()}</p>
        <p>Quantity: ${quantity} copies</p>
      </div>
      
      <div class="barcodes-container">
        ${barcodeItems}
      </div>
    </body>
    </html>
  `;
}

// Export for use in other modules if needed
if (typeof module !== 'undefined' && module.exports) {
  module.exports = { printBarcode };
}
