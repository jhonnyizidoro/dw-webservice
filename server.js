const express = require('express')
const mysql = require('mysql2')

const app = express()

const connection = mysql.createConnection({
	host: 'mysql743.umbler.com',
	port: '41890',
	user: 'ads-db-user',
	password: '36zpRW-6|Es',
	database: 'ads',
})

app.get('/data/:table', async (req, res) => {
	try {
		const { table } = req.params
		const response = []

		connection.query(
			`SELECT * FROM ${table}`,
			(error, result, fields) => {
				if (error) {
					res.json(error)
				} else {
					result.forEach(row => {
						const parsedRow = {}
						Object.keys(row).forEach(key => {
							parsedRow[key] = row[key]
						})
						response.push(parsedRow)
					})
					res.json(response)
				}
			},
		)
	} catch (error) {
		res.json(error)
	} finally {
		connection.end()
	}
})

app.listen(process.env.PORT || 80, () => {
	console.log('Server running')
})