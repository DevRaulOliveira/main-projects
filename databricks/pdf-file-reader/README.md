# PDF File Reader Documentation

## Purpose
This notebook is designed to automate the extraction of data from PDF files, converting specific information into structured tables for analysis, integration, and process automation within Databricks environments.

## Requirements
* **Required Library:** pdfplumber
  - Install with: `pip install pdfplumber`
  - Restart the cluster after installation to ensure proper operation.
* **Environment:** Databricks with Python support (Serverless or Interactive Clusters)

## Operation and Key Rules
* **Extraction Vectors:**
  - Table conversion relies exclusively on the defined vectors (`vetores`), which represent areas of interest in the PDF layout.
  - Each vector corresponds to a position (coordinates x0, top, x1, bottom) where the desired information is located.
  - **Fundamental Rule:** All processed PDF files must have words located in the same vectors and the same length of information. PDFs with different layouts or fields in different positions may produce inconsistent or incomplete results.
* **Column Mapping:**
  - The column names of the resulting table must match the order and quantity of the defined vectors.
  - The code associates each vector with a specific column, ensuring that extracted data is organized correctly.
* **Coordinate Definition:**
  - Coordinates should be adjusted as needed:
    - `x0`: initial coordinate on the X axis
    - `top`: initial coordinate on the Y axis
    - `x1`: final coordinate on the X axis
    - `bottom`: final coordinate on the Y axis
  - It is recommended to adjust the initial and final coordinates (subtracting/adding 2 to 5 units) to ensure no characters are excluded.

## Process Steps
1. Install and configure the `pdfplumber` library.
2. Define the extraction vectors according to the PDF layout.
3. List the PDF files to be processed.
4. For each file, extract text from the specified areas and build a dictionary with the data.
5. Convert the list of dictionaries into a DataFrame for analysis and visualization.

## Usage Examples
* Extract words and text from specific PDF areas using `pdfplumber` and defined vectors.
* Print results to validate the extracted data.
* Convert extracted data into a DataFrame for visualization and analysis.

## Maintenance and Adaptation Guidelines
* **Adapting to New Layouts:**
  - If the PDF layout changes, update the vectors and column names to reflect the new positions of the information.
  - Test extraction with different files to ensure consistency.
* **Data Validation:**
  - Always check that the number of vectors and columns matches the content of the PDFs.
  - Print extracted data to validate accuracy before advanced analysis.
* **Error Handling:**
  - The code includes checks to ensure files exist and extraction areas are correct.
  - Adapt exception handling as needed for specific scenarios.
* **PDF Standardization:**
  - Successful extraction depends on standardized PDFs. Files with layout variations require adjustments to vectors and extraction logic.
  - It is recommended to document every change to vectors and columns for easier future maintenance.
* **Notebook Expansion:**
  - This notebook can be expanded to process multiple pages or different document types by adapting the extraction logic.

## Important Notes
* Ensure the PDF file path is correct and accessible in the environment.
* Adjust extraction areas according to the structure of the analyzed PDF document.
* The approach can be adapted for different document layouts by modifying coordinates and areas of interest.
* Document all changes to ensure traceability and facilitate future adaptations.

## Results

- PDF File:

<img width="1337" height="1045" alt="image" src="https://github.com/user-attachments/assets/37c033da-dacf-4e1c-9b55-5e23b0ba005b" />



- Data:

<img width="1867" height="973" alt="image" src="https://github.com/user-attachments/assets/d804cce3-f8d3-42d8-93ff-89b401bec367" />


---

This consolidated documentation has been reviewed to ensure maximum clarity, detail, and ease of maintenance. Follow the guidelines to adapt the notebook as needed and ensure reliable results.
