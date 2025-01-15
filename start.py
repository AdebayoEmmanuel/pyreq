import argparse
import devops_jenkins

def main():
    parser = argparse.ArgumentParser()
    subparsers = parser.add_subparsers(dest="command")

    validate_parser = subparsers.add_parser("validate")
    prepare_parser = subparsers.add_parser("prepare")
    execute_parser = subparsers.add_parser("execute")

    for subparser in (validate_parser, prepare_parser, execute_parser):
        subparser.add_argument("--action", required=True)
        subparser.add_argument("--env", required=True)
        subparser.add_argument("--reg", required=True)
        subparser.add_argument("--stages", required=True)
        subparser.add_argument("--override", required=True)
        subparser.add_argument("--token", required=True)
        subparser.add_argument("--resume", required=True)
        subparser.add_argument("--git", required=True)

    args = parser.parse_args()
    jenkins = devops_jenkins.DevOpsJenkins(args.action, args.env, args.reg, args.stages, args.override, args.token, args.resume, args.git)

    if args.command == "validate":
        jenkins.validate_inputs()
    elif args.command == "prepare":
        jenkins.prepare_queue()
    elif args.command == "execute":
        jenkins.execute_queue()

if __name__ == "__main__":
    main()
