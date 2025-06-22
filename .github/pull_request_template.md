---
name: Pull Request
about: Template for contributing to the Terraform Associate 003 Learning Project
title: ''
labels: ''
assignees: ''

---

## 📋 Pull Request Summary

### Type of Change
<!-- Mark the type of change with an 'x' -->
- [ ] 🆕 **New Module**: Adding a new learning module or example
- [ ] 📝 **Documentation**: Improving or adding documentation
- [ ] 🐛 **Bug Fix**: Fixing an issue in existing code or documentation
- [ ] ✨ **Enhancement**: Improving existing functionality or examples
- [ ] 🔧 **Refactor**: Code cleanup or restructuring without changing functionality
- [ ] 🧪 **Testing**: Adding or improving tests and validations
- [ ] 🔒 **Security**: Security-related improvements or fixes
- [ ] 🎨 **Learning Experience**: Improving the educational value or user experience

### Description
<!-- Provide a clear and concise description of what this PR does -->



### Related Issues
<!-- Link any related issues using keywords like "Closes", "Fixes", "Resolves" -->
- Closes #
- Relates to #
- Fixes #

---

## 🎯 Learning Objectives

### What Will Learners Gain?
<!-- Describe what learners will learn from this contribution -->
- [ ] Understanding of new Terraform concepts
- [ ] Practical experience with specific providers
- [ ] Best practices for infrastructure as code
- [ ] Troubleshooting and problem-solving skills
- [ ] Security practices and considerations
- [ ] Other: _________________________________

### Target Audience
<!-- Who is this contribution intended for? -->
- [ ] Terraform beginners
- [ ] Intermediate Terraform users
- [ ] Advanced users looking for specific patterns
- [ ] Those preparing for Terraform Associate certification

---

## 🔧 Technical Details

### Changes Made
<!-- Describe the technical changes in detail -->
#### Terraform Configurations
- [ ] Added new resources: _________________________________
- [ ] Modified existing configurations: ____________________
- [ ] Updated provider versions: ____________________________
- [ ] Added variables/outputs: ______________________________

#### Documentation
- [ ] Updated README files
- [ ] Added inline code comments
- [ ] Created troubleshooting guides
- [ ] Added architecture diagrams
- [ ] Updated examples

#### Testing & Validation
- [ ] Terraform configurations validated (`terraform validate`)
- [ ] Code formatted (`terraform fmt`)
- [ ] Successfully planned and applied
- [ ] Tested destruction of resources
- [ ] Cross-platform testing completed

### Infrastructure Components
<!-- List the AWS/other cloud resources this PR affects -->
| Resource Type | Name | Purpose |
|---------------|------|---------|
| | | |
| | | |

---

## 🧪 Testing Checklist

### Pre-Submission Testing
- [ ] **Terraform Validation**: `terraform validate` passes
- [ ] **Code Formatting**: `terraform fmt -check` passes
- [ ] **Plan Generation**: `terraform plan` executes without errors
- [ ] **Apply Testing**: `terraform apply` works as expected
- [ ] **Destroy Testing**: `terraform destroy` cleans up resources
- [ ] **Documentation Testing**: All examples and commands work as described

### Security Validation
- [ ] **No Hardcoded Secrets**: No credentials or sensitive data in code
- [ ] **Sensitive Variables**: Marked with `sensitive = true` where appropriate
- [ ] **Security Scanner**: Passed tfsec/checkov scanning (if applicable)
- [ ] **Best Practices**: Follows Terraform security best practices
- [ ] **Warnings Added**: Security considerations documented

### Learning Experience Testing
- [ ] **Clear Instructions**: Step-by-step instructions are accurate
- [ ] **Error Handling**: Common errors addressed in troubleshooting
- [ ] **Prerequisites**: All requirements clearly stated and testable
- [ ] **Learning Path**: Fits well with existing module progression

---

## 📚 Documentation

### Documentation Updates
- [ ] **Module README**: Updated or created comprehensive README
- [ ] **Code Comments**: Added explanatory comments for learning
- [ ] **Architecture Diagrams**: Visual representations where helpful
- [ ] **Troubleshooting Section**: Common issues and solutions documented
- [ ] **Prerequisites**: Clear setup requirements listed
- [ ] **Next Steps**: Guidance for continued learning

### Example Quality
- [ ] **Working Examples**: All code examples tested and functional
- [ ] **Realistic Scenarios**: Examples reflect real-world use cases
- [ ] **Progressive Complexity**: Examples build upon previous learning
- [ ] **Clear Explanations**: Each example has clear purpose and context

---

## 🔒 Security Considerations

### Security Review
- [ ] **No Exposed Credentials**: No AWS keys, passwords, or secrets in code
- [ ] **Environment Variables**: Sensitive data handled via variables
- [ ] **Access Controls**: Appropriate security groups and permissions
- [ ] **Encryption**: Data encryption enabled where appropriate
- [ ] **Network Security**: Proper VPC and subnet configurations
- [ ] **Resource Tagging**: Consistent and secure tagging strategy

### Educational Security Notes
- [ ] **Production Warnings**: Clear warnings about production usage
- [ ] **Cost Implications**: Resource costs and cleanup instructions
- [ ] **Permission Requirements**: AWS IAM permissions documented
- [ ] **Safe Defaults**: Secure-by-default configurations used

---

## 💰 Cost Considerations

### AWS Resource Costs
<!-- Estimate the cost impact of resources created by this PR -->
- [ ] **Free Tier Eligible**: Resources use AWS free tier when possible
- [ ] **Cost Estimates**: Estimated monthly cost: $_____________
- [ ] **Resource Cleanup**: Clear instructions for resource cleanup
- [ ] **Auto-Cleanup**: Lifecycle rules or scheduled deletion configured
- [ ] **Cost Warnings**: Potential cost implications documented

### Resource Lifecycle
- [ ] **Quick Setup**: Resources can be created quickly for learning
- [ ] **Easy Cleanup**: Simple `terraform destroy` removes all resources
- [ ] **No Dependencies**: Doesn't leave orphaned resources

---

## 🎓 Educational Value

### Learning Progression
- [ ] **Builds on Previous**: Leverages concepts from earlier modules
- [ ] **Standalone Value**: Can be understood independently
- [ ] **Clear Objectives**: Learning goals explicitly stated
- [ ] **Practical Application**: Real-world scenarios demonstrated

### Teaching Quality
- [ ] **Step-by-Step**: Instructions are detailed and sequential
- [ ] **Explained Concepts**: Why, not just how, is explained
- [ ] **Common Pitfalls**: Typical mistakes and how to avoid them
- [ ] **Best Practices**: Industry standards and recommendations included

---

## 🔄 Compatibility

### Version Compatibility
- [ ] **Terraform Version**: Compatible with required Terraform version (>= 1.2.0)
- [ ] **Provider Versions**: Uses supported provider versions
- [ ] **Platform Support**: Tested on multiple operating systems
- [ ] **Backward Compatibility**: Doesn't break existing modules

### Integration
- [ ] **Module Integration**: Works well with other project modules
- [ ] **Naming Consistency**: Follows project naming conventions
- [ ] **File Structure**: Adheres to project file organization

---

## 📸 Screenshots/Output (if applicable)

### Terminal Output
<!-- Include relevant terminal output, especially for new modules -->
```bash
# Example: terraform plan output
# Example: terraform apply output
# Example: AWS Console screenshots
```

### Architecture Diagrams
<!-- Include any visual representations of the infrastructure -->

---

## 📋 Pre-Submission Checklist

### Code Quality
- [ ] Code follows project style guidelines
- [ ] All files are properly formatted (`terraform fmt`)
- [ ] No syntax errors (`terraform validate`)
- [ ] Resource names follow naming conventions
- [ ] Variables and outputs are properly documented

### Documentation Quality
- [ ] README is comprehensive and up-to-date
- [ ] All code examples are tested and working
- [ ] Prerequisites are clearly listed
- [ ] Troubleshooting section addresses common issues
- [ ] Learning objectives are clearly stated

### Security & Safety
- [ ] No hardcoded credentials or secrets
- [ ] Security best practices followed
- [ ] Production usage warnings included
- [ ] Cost implications documented
- [ ] Resource cleanup instructions provided

### Testing & Validation
- [ ] All Terraform configurations tested
- [ ] Documentation examples verified
- [ ] Cross-platform compatibility checked
- [ ] Security scanning completed (if applicable)

---

## 🤝 Reviewer Guidelines

### For Maintainers
When reviewing this PR, please check:

#### Technical Review
- [ ] Terraform syntax and best practices
- [ ] Security implications and safeguards
- [ ] Resource efficiency and cost considerations
- [ ] Integration with existing modules

#### Educational Review
- [ ] Learning objectives clarity and achievability
- [ ] Documentation quality and completeness
- [ ] Example relevance and accuracy
- [ ] Progressive difficulty appropriate for target audience

#### Community Standards
- [ ] Follows project Code of Conduct
- [ ] Maintains inclusive and welcoming tone
- [ ] Encourages learning and experimentation
- [ ] Provides constructive guidance

---

## 🎯 Additional Notes

### Special Considerations
<!-- Any special considerations, known limitations, or future improvements -->



### Future Enhancements
<!-- Ideas for future improvements or related modules -->



### Questions for Reviewers
<!-- Specific questions you'd like reviewers to consider -->



---

## 📞 Contact Information

If reviewers have questions about this PR:
- **GitHub**: @your-github-username
- **Email**: your-email@example.com (optional)
- **Best way to reach me**: _______________

---

**Thank you for contributing to the Terraform Associate 003 Learning Project!** 🎉

Your contribution helps make infrastructure learning accessible and enjoyable for everyone. We appreciate the time and effort you've put into making this project better.

### After Submission
- [ ] Monitor for reviewer feedback
- [ ] Respond to comments and suggestions promptly
- [ ] Make requested changes and push updates
- [ ] Participate in the review discussion constructively

---

*This template helps ensure high-quality contributions that enhance the learning experience for all users of this project.*
