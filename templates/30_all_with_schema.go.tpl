{{- $alias := .Aliases.Table .Table.Name}}
{{- $table := .Table.Name}}
{{- $canSoftDelete := .Table.CanSoftDelete $.AutoColumns.Deleted }}
// {{$alias.UpPlural}}WithSchema retrieves all the records of target schema using an executor.
func {{$alias.UpPlural}}WithSchema(targetSchema string, mods ...qm.QueryMod) {{$alias.DownSingular}}Query {
    schemaTable := fmt.Sprintf("\"%s\".{{$table}}", targetSchema)
    allColumns := fmt.Sprintf("\"%s\".{{$table}}.*", targetSchema)
    {{if and .AddSoftDeletes $canSoftDelete -}}
    mods = append(mods, qm.From(schemaTable), qmhelper.WhereIsNull("{{$table}}.{{or $.AutoColumns.Deleted "deleted_at" | $.Quotes}}"))
    {{else -}}
    mods = append(mods, qm.From(schemaTable))
    {{end -}}

    q := NewQuery(mods...)
    if len(queries.GetSelect(q)) == 0 {
        queries.SetSelect(q, []string{allColumns})
    }

    return {{$alias.DownSingular}}Query{q}
}