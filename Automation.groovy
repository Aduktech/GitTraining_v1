// Automate data entry
def data = ['John', 'Doe', 'johndoe@example.com']
def csvFile = new File('data.csv')
csvFile.append(data.join(',') + '\n')

//Generate a report
def report = new File('report.txt')
report.write('Report generated on' + new Date() + '\n')