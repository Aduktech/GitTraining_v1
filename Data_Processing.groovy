// Parse a CSV file
def csvFile = new File('data.csv')
def csvDate = csvFile.readLines()
csvDate.each { line ->
    def columns = line.split(',')
    printIn columns
}

// Process JSON data
import groovy.json.JsonSlurper
def jsonData = new
JsonSlurper().parseText('{"name": "John", "age": 30}')
printIn jsonData.name
printIn jsonData.age