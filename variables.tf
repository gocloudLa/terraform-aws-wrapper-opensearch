variable "metadata" {
  type = any
}

variable "opensearch_parameters" {
  type        = any
  description = ""
  default     = {}
}

variable "opensearch_defaults" {
  description = "Map of default values which will be used for each item."
  type        = any
  default     = {}
}
