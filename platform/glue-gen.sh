
# Remove old glue flies
rm -rf platform/src/glue
rm -rf platform/src/glue_manual

# Generate manual glue - NOTE this is a workaround until glue generates for all types
roc glue ../roc/crates/glue/src/RustGlue.roc platform/src/glue_manual platform/main-manual-glue.roc
cp -r platform/src/glue_manual/roc_app/src/ platform/src/glue_manual/src/
rm -rf platform/src/glue_manual/roc_app
rm -rf platform/src/glue_manual/roc_std

# Generate manual glue Cargo.toml
cat > platform/src/glue_manual/Cargo.toml << EOF 
[package]
name = "glue_manual"
description = "This was generated by `roc glue`. It provides glue between a specific Roc platform and a Rust host."
version = "1.0.0"
edition = "2021"

[dependencies]
roc_std = { path = "../glue/roc_std" }
EOF

# Generate glue for the platform
roc glue ../roc/crates/glue/src/RustGlue.roc platform/src/glue platform/main.roc