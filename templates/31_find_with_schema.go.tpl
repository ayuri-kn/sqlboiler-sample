{{- if .Table.IsView -}}
{{- else -}}
{{- $alias := .Aliases.Table .Table.Name -}}
{{- $colDefs := sqlColDefinitions .Table.Columns .Table.PKey.Columns -}}
{{- $pkNames := $colDefs.Names | stringMap (aliasCols $alias) | stringMap .StringFuncs.camelCase | stringMap .StringFuncs.replaceReserved -}}
{{- $pkArgs := joinSlices " " $pkNames $colDefs.Types | join ", " -}}
{{- $canSoftDelete := .Table.CanSoftDelete $.AutoColumns.Deleted }}

// Find{{$alias.UpSingular}}WithSchema retrieves a single record by ID with an executor.
// If selectCols is empty Find will return all columns.
func Find{{$alias.UpSingular}}WithSchema({{if .NoContext}}exec boil.Executor{{else}}ctx context.Context, exec boil.ContextExecutor{{end}}, targetSchema string, {{$pkArgs}}, selectCols ...string) (*{{$alias.UpSingular}}, error) {
	{{$alias.DownSingular}}Obj := &{{$alias.UpSingular}}{}

	sel := "*"
	if len(selectCols) > 0 {
		sel = strings.Join(strmangle.IdentQuoteSlice(dialect.LQ, dialect.RQ, selectCols), ",")
	}
	query := fmt.Sprintf(
		"select %s from \"%s\".{{.Table.Name}} where {{if .Dialect.UseIndexPlaceholders}}{{whereClause .LQ .RQ 1 .Table.PKey.Columns}}{{else}}{{whereClause .LQ .RQ 0 .Table.PKey.Columns}}{{end}}{{if and .AddSoftDeletes $canSoftDelete}} and {{or $.AutoColumns.Deleted "deleted_at" | $.Quotes}} is null{{end}}", sel, targetSchema,
	)

	q := queries.Raw(query, {{$pkNames | join ", "}})

	err := q.Bind({{if not .NoContext}}ctx{{else}}nil{{end}}, exec, {{$alias.DownSingular}}Obj)
	if err != nil {
		{{if not .AlwaysWrapErrors -}}
		if errors.Is(err, sql.ErrNoRows) {
			return nil, sql.ErrNoRows
		}
		{{end -}}
		return nil, errors.Wrap(err, "{{.PkgName}}: unable to select from {{.Table.Name}}")
	}

	{{if not .NoHooks -}}
	if err = {{$alias.DownSingular}}Obj.doAfterSelectHooks({{if not .NoContext}}ctx, {{end -}} exec); err != nil {
		return {{$alias.DownSingular}}Obj, err
	}
	{{- end}}

	return {{$alias.DownSingular}}Obj, nil
}

{{- end -}}