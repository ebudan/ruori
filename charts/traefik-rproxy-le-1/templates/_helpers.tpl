{{/* vim: set filetype=mustache: */}}

{{/*
This helper is copied from the Traefik Helm charts to avoid
having to specify the namespace in two different places. 
*/}}
{{- define "subtraefik.namespace" -}}
{{- if .Values.traefik.namespaceOverride -}}
{{- .Values.traefik.namespaceOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- .Release.Namespace -}}
{{- end -}}
{{- end -}}
