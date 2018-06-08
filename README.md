![docker hub](https://img.shields.io/docker/pulls/trashanger/devops2.svg?style=flat-square)
![docker hub](https://img.shields.io/docker/stars/trashanger/devops2.svg?style=flat-square)

https://hub.docker.com/r/trashanger/devops2/tags/
https://github.com/trash-anger/eval_devops2

Avec l'application de bonnes pratiques pour la sécurité du pipeline de build demandé pour l'évaluation devops 2, certains éléments ne sont pas visible dans le .zip de rendu.

Bien qu'un peu plus complexe à mettre en place, l'utilisation de dind (docker in docker) est plus sécurisé que celle de dood. 

Le build est exécuté avec un job de type multibranch pipeline :
image.png
![image.png](https://raw.githubusercontent.com/trash-anger/eval_devops2/v3/img/img1.png)

L'intérêt de cette méthode est que le pipeline ne nécessite qu'un simple Jenkinsfile pour toutes les branches.
![image.png](https://raw.githubusercontent.com/trash-anger/eval_devops2/v3/img/img2.png)

Les builds sont triggués par un webhook configuré dans github :
![image.png](https://raw.githubusercontent.com/trash-anger/eval_devops2/v3/img/img3.png)

L'intérêt de cette méthode est que le build est triggué uniquement lorsqu'une modification intervient sur une branche et il ne s'opère que sur cette branche.

Voici le xml de config de ce pipeline :
```
cat ./jobs/PhpPipeline/config.xml
<?xml version='1.1' encoding='UTF-8'?>
<flow-definition plugin="workflow-job@2.12.2">
  <actions/>
  <description></description>
  <keepDependencies>false</keepDependencies>
  <properties>
    <org.jenkinsci.plugins.workflow.job.properties.PipelineTriggersJobProperty>
      <triggers>
        <com.cloudbees.jenkins.GitHubPushTrigger plugin="github@1.29.1">
          <spec></spec>
        </com.cloudbees.jenkins.GitHubPushTrigger>
      </triggers>
    </org.jenkinsci.plugins.workflow.job.properties.PipelineTriggersJobProperty>
  </properties>
  <definition class="org.jenkinsci.plugins.workflow.cps.CpsScmFlowDefinition" plugin="workflow-cps@2.45">
    <scm class="hudson.plugins.git.GitSCM" plugin="git@3.9.1">
      <configVersion>2</configVersion>
      <userRemoteConfigs>
        <hudson.plugins.git.UserRemoteConfig>
          <url>https://github.com/trash-anger/eval_devops2.git</url>
          <credentialsId>github_cred</credentialsId>
        </hudson.plugins.git.UserRemoteConfig>
      </userRemoteConfigs>
      <branches>
        <hudson.plugins.git.BranchSpec>
          <name>*/v1</name>
        </hudson.plugins.git.BranchSpec>
      </branches>
      <doGenerateSubmoduleConfigurations>false</doGenerateSubmoduleConfigurations>
      <submoduleCfg class="list"/>
      <extensions/>
    </scm>
    <scriptPath>Jenkinsfile</scriptPath>
    <lightweight>true</lightweight>
  </definition>
  <triggers/>
  <disabled>false</disabled>
</flow-definition>
```

L'utilisation d'un multibranch pipeline nous permet aussi de profiter d'une variable non présente dans les autres type de jobs : $(BRANCH_NAME). Il nous à été particulièrement utile car il nous permet de builder nos images avec un tag et de pousser celle-ci indépendamment sur le hub.

```
docker exec -ti dind_jenkins_1 sh -c "docker images"
REPOSITORY           TAG                 IMAGE ID            CREATED             SIZE
trashanger/devops2   v2                  c640de28fd35        About an hour ago   276MB
trashanger/devops2   v3                  3ea97d745e56        About an hour ago   276MB
trashanger/devops2   v1                  234d684008b6        2 hours ago         285MB
```

Les informations d'authentification sont toutes stockées dans la configuration interne à Jenkins, ce qui les rends non visible des développeurs travaillant sur le projet. 
