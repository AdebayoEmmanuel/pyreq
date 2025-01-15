def beautify_terminal_output(header="", body="", border_style="="):
    print(f"{header}\n{border_style * len(header)}\n{body}")

def get_jenkins_job_name(stage_type, service_name, environment_name, action, application_name):
    return f"{stage_type}-{service_name}-{environment_name}-{action}-{application_name}"

def logging_info(message):
    print(f"INFO: {message}")

def logging_warning(message):
    print(f"WARNING: {message}")

def logging_error(message):
    print(f"ERROR: {message}")
