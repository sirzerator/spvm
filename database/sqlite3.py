#!/usr/bin/python
# -*- coding: utf-8 -*-
import sqlite3


class DBModule:

	def __init__(self, database, username, password):
		self.name = 'sqlite3'
		self.conn = sqlite3.connect(database)
		self.c = self.conn.cursor()

	def __del__(self):
		self.c.close()

	def create_table(self, string):
		self.c.execute(string)

		self.conn.commit()

	def last_insert_rowid(self):
		self.c.execute("SELECT last_insert_rowid()")
		for row in self.c:
			insert_id = row[0]

		return insert_id

	def create(self, table=None, fields=None):
		if table is None or fields is None:
			return False
		else:
			values = list()
			for value in fields.values():
				try:
					float(value)
					values.append(value)
				except(ValueError):
					values.append('"' + value + '"')

			print('INSERT INTO {0} ({1}) VALUES ({2});'.format(table, ','.join(fields.keys()), ','.join(values)))
			try:
				self.c.execute('INSERT INTO {0} ({1}) VALUES ({2});'.format(table, ','.join(fields.keys()), ','.join(values)))
				self.conn.commit()
			except:
				print('DB Error.')
				return False

			return True

	def retrieve(self, table=None, fields=None, where=None, join=None):
		if table is None or fields is None:
			return False
		else:
			query = 'SELECT {0} FROM {1}'.format(",".join(fields), table)

			if where is not None:
				where_fields = list()
				for field, value in where.items():
					try:
						float(value)
						where_fields.append(field + ' = ' + value)
					except(ValueError):
						where_fields.append(field + ' = "' + value + '"')
				query +=  ' WHERE {0}'.format(' AND '.join(where_fields));

			query += ';'

			try:
				print(query)
				self.c.execute(query)
			except:
				print('DB Error.')
				return False

			count = 0
			rows = list()
			result = dict()
			for row in self.c:
				count += 1
				row_dict = dict()
				position = 0
				for column in self.c.description:
					row_dict[column[0]] = row[position]
					position += 1

				rows.append(row_dict)

			result['rows'] = rows
			result['count'] = count

			return result

	def update(self, table=None, fields=None, where=None):
		if table is None or fields is None:
			return False
		else:
			fields_query = list()
			for field, value in fields.items():
				try:
					float(value)
					fields_query.append(field + ' = ' + value)
				except(ValueError):
					fields_query.append(field + ' = "' + value + '"')

			query = 'UPDATE {0} SET {1}'.format(table, ', '.join(fields_query))

			if where is not None:
				where_fields = list()
				for field, value in where.items():
					try:
						float(value)
						where_fields.append(field + ' = ' + value)
					except(ValueError):
						where_fields.append(field + ' = "' + value + '"')
					query +=  ' WHERE {0}'.format(' AND '.join(where_fields));

			query += ';'

			try:
				print(query)
				self.c.execute(query)
			except:
				print('DB Error.')
				return False

			return True

	def delete(self, table=None, where=None):
		if table is None or where is None:
			return False
		else:
			where_fields = list()
			for field, value in where.items():
				try:
					float(value)
					where_fields.append(field + ' = ' + value)
				except(ValueError):
					where_fields.append(field + ' = "' + value + '"')

			print('DELETE FROM {0} WHERE {1};'.format(table, ' AND '.join(where_fields)))
			try:
				self.c.execute('DELETE FROM {0} WHERE {1};'.format(table, ' AND '.join(where_fields)))
				self.conn.commit()
			except:
				print('DB Error.')
				return False

		return True