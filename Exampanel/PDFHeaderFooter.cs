using iTextSharp.text;
using iTextSharp.text.pdf;
using System;
using System.IO;
using System.Web;

public class PDFHeaderFooter : PdfPageEventHelper
{
    private string examTitle;

    public PDFHeaderFooter(string examTitle)
    {
        this.examTitle = examTitle;
    }

    public override void OnEndPage(PdfWriter writer, Document document)
    {
        // Create a 2-column header table
        PdfPTable header = new PdfPTable(2);
        header.TotalWidth = document.PageSize.Width - 72; // page width minus margins
        header.SetWidths(new float[] { 1, 4 }); // column widths

        // Image path and logic
        string imagePath = HttpContext.Current.Server.MapPath("~/assets/Owl of Wisdom.png");

        // Check if the image file exists
        if (File.Exists(imagePath))
        {
            iTextSharp.text.Image logo = iTextSharp.text.Image.GetInstance(imagePath);
            logo.ScaleToFit(120f, 120f);  // Scale image to fit
            logo.SetAbsolutePosition(36f, document.PageSize.Height - 120f); // Adjust position dynamically

            // Add logo to header
            PdfPCell logoCell = new PdfPCell(logo);
            logoCell.Border = Rectangle.NO_BORDER;
            logoCell.HorizontalAlignment = Element.ALIGN_LEFT;
            header.AddCell(logoCell);
        }
        else
        {
            throw new Exception("Logo image not found at the specified path.");
        }

        // Text Title
        PdfPCell titleCell = new PdfPCell();
        titleCell.Border = Rectangle.NO_BORDER;

        Font titleFont = FontFactory.GetFont("Arial", 16, Font.BOLD, BaseColor.BLUE);
        Font subFont = FontFactory.GetFont("Arial", 12, Font.NORMAL, BaseColor.BLACK);

        Phrase phrase = new Phrase();
        phrase.Add(new Chunk("QuizNest\n", titleFont));
        phrase.Add(new Chunk($"Exam: {examTitle}\nDate: {DateTime.Now:dd MMM yyyy}", subFont));
        titleCell.AddElement(phrase);
        header.AddCell(titleCell);

        // Write the header to the document
        header.WriteSelectedRows(0, -1, 36, document.PageSize.Height - 30, writer.DirectContent);
    }
}
