function downloadFile() {
    const filePath = 'path/to/your/file.txt';
    const fileName = 'downloaded_file.txt';
    const link = document.createElement('a');
    link.href = filePath;
    link.download = fileName;
    link.click();
    link.remove();
}
