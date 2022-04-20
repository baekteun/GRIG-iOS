# Don't run this during index builds
if [ $ACTION = "indexbuild" ]; then exit 0; fi

# Go to the build root and search up the chain to find the Derived Data Path where the source packages are checked out.
PROJECT_ROOT="$(dirname ${SRCROOT})"
DERIVED="$(dirname ${PROJECT_ROOT})"
DERIVED_DATA_CANDIDATE="${DERIVED}/Tuist/Dependencies/SwiftPackageManager/.build"
if [ -z "${DERIVED_DATA_CANDIDATE}" ]; then
    echo >&2 "Plz 'tuist fetch' "
    exit 1
fi

# Grab a reference to the directory where scripts are checked out
SCRIPT_PATH="${DERIVED_DATA_CANDIDATE}/checkouts/apollo-ios/scripts"

if [ -z "${SCRIPT_PATH}" ]; then
    echo >&2 "error: Couldn't find the CLI script in your checked out SPM packages; make sure to add the framework to your project."
    exit 1
fi

cd "${PROJECT_ROOT}/Service/APIKit"
"${SCRIPT_PATH}"/run-bundled-codegen.sh codegen:generate --target=swift --namespace=GRIGAPI --includes=./**/*.graphql --localSchemaFile="schema.json" ../Domain/Sources/Entities
